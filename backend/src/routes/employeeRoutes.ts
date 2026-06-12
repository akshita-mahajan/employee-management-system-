import { Router, Response } from "express";
import { EmployeeRepository } from "../repositories/EmployeeRepository.js";
import pool from "../config/database.js";
import { checkRole, AuthenticatedRequest } from "../middleware/rbacMiddleware.js";

const router = Router();
const empRepo = new EmployeeRepository();

// GET all employees (paginated + filters)
router.get("/", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response) => {
  const { page, limit, search, sortBy, sortOrder, status, departmentId } = req.query;

  try {
    const filters: any = {};
    if (status) filters.status = status;
    if (departmentId) filters.departmentId = departmentId;

    // If standard employee or intern, restrict view to only their own department or active directory
    // (We allow listing for directory lookup, but can filter active records)
    const result = await empRepo.findPaginated({
      page: page ? parseInt(page as string) : 1,
      limit: limit ? parseInt(limit as string) : 10,
      search: search as string,
      sortBy: sortBy as string,
      sortOrder: (sortOrder as "ASC" | "DESC") || "ASC",
      filters,
    });

    const resolvedData = await Promise.all(
      result.data.map(async (emp: any) => {
        let deptName = "Unassigned";
        if (emp.department_id) {
          const deptRes = await pool.query("SELECT name FROM departments WHERE id = $1", [emp.department_id]);
          if (deptRes.rows.length > 0) {
            deptName = deptRes.rows[0].name;
          }
        }
        return {
          id: emp.id,
          employeeId: emp.employee_id,
          name: `${emp.first_name} ${emp.last_name}`,
          firstName: emp.first_name,
          lastName: emp.last_name,
          department: deptName,
          departmentId: emp.department_id,
          designation: emp.designation,
          email: emp.email,
          phone: emp.phone,
          joiningDate: emp.joining_date ? emp.joining_date.toISOString().split("T")[0] : "",
          status: emp.status,
          role: "EMPLOYEE",
        };
      })
    );

    res.json({
      data: resolvedData,
      metadata: result.metadata,
    });
  } catch (error) {
    console.error("Fetch employees failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// POST create employee
router.post("/", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { firstName, lastName, employeeId, email, phone, departmentId, department, designation, joiningDate, status } = req.body;

  if (!firstName || !lastName || !employeeId || !email) {
    return res.status(400).json({ message: "Required fields are missing" });
  }

  try {
    // Validate unique constraints
    const emailCheck = await pool.query("SELECT id FROM employees WHERE email = $1 AND deleted_at IS NULL", [email]);
    if (emailCheck.rows.length > 0) {
      return res.status(409).json({ message: "An employee with this email already exists" });
    }
    const idCheck = await pool.query("SELECT id FROM employees WHERE employee_id = $1 AND deleted_at IS NULL", [employeeId]);
    if (idCheck.rows.length > 0) {
      return res.status(409).json({ message: "An employee with this Employee ID already exists" });
    }
    if (phone) {
      const phoneCheck = await pool.query("SELECT id FROM employees WHERE phone = $1 AND deleted_at IS NULL", [phone]);
      if (phoneCheck.rows.length > 0) {
        return res.status(409).json({ message: "An employee with this phone number already exists" });
      }
    }

    // Resolve department string name to UUID if needed
    let resolvedDeptId = departmentId || null;
    if (!resolvedDeptId && department) {
      const deptCheck = await pool.query(
        "SELECT id FROM departments WHERE name = $1 AND deleted_at IS NULL",
        [department]
      );
      if (deptCheck.rows.length > 0) {
        resolvedDeptId = deptCheck.rows[0].id;
      }
    }

    // Check if user account needs to be created
    let userId = null;
    const userCheck = await pool.query("SELECT id FROM users WHERE email = $1", [email]);
    if (userCheck.rowCount === 0) {
      // Create user account with default password hash
      const userRes = await pool.query(
        "INSERT INTO users (email, password_hash) VALUES ($1, $2) RETURNING id",
        [email, "$2b$10$dummyhashjanemillerpassword"]
      );
      userId = userRes.rows[0].id;
      // Add default role
      await pool.query(
        "INSERT INTO user_roles (user_id, role_id) VALUES ($1, 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804')",
        [userId]
      );
    } else {
      userId = userCheck.rows[0].id;
    }

    const newEmp = await empRepo.insert({
      user_id: userId,
      employee_id: employeeId,
      first_name: firstName,
      last_name: lastName,
      email,
      phone: phone || null,
      department_id: resolvedDeptId,
      designation,
      joining_date: joiningDate ? new Date(joiningDate) : new Date(),
      status: status || "ACTIVE",
      reporting_manager_id: null,
    });

    res.status(201).json(newEmp);
  } catch (error) {
    console.error("Create employee failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// PUT update employee
router.put("/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "EMPLOYEE"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  const { firstName, lastName, employeeId, email, phone, departmentId, department, designation, joiningDate, status } = req.body;

  try {
    const existing = await empRepo.findById(id);
    if (!existing) {
      return res.status(404).json({ message: "Employee not found" });
    }

    // Security Check: HR Admin cannot manage Super Admin
    if (req.user?.role === "HR_ADMIN" || req.user?.role === "HR") {
      if (existing.user_id) {
        const targetUserRolesRes = await pool.query(
          `SELECT r.name FROM roles r 
           JOIN user_roles ur ON r.id = ur.role_id 
           WHERE ur.user_id = $1`,
          [existing.user_id]
        );
        const rolesList = targetUserRolesRes.rows.map((r: any) => r.name);
        if (rolesList.includes("SUPER_ADMIN") || rolesList.includes("ADMIN")) {
          return res.status(403).json({ message: "Access Denied: HR Admin cannot manage Super Admin" });
        }
      }
    }

    // Security Check: Standard employee can only edit their OWN profile
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      if (req.user.email !== existing.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only edit their own profile" });
      }
    }

    // Validate unique constraints
    if (email && email !== existing.email) {
      const emailCheck = await pool.query("SELECT id FROM employees WHERE email = $1 AND deleted_at IS NULL AND id <> $2", [email, id]);
      if (emailCheck.rows.length > 0) {
        return res.status(409).json({ message: "An employee with this email already exists" });
      }
    }
    if (employeeId && employeeId !== existing.employee_id) {
      const idCheck = await pool.query("SELECT id FROM employees WHERE employee_id = $1 AND deleted_at IS NULL AND id <> $2", [employeeId, id]);
      if (idCheck.rows.length > 0) {
        return res.status(409).json({ message: "An employee with this Employee ID already exists" });
      }
    }
    if (phone && phone !== existing.phone) {
      const phoneCheck = await pool.query("SELECT id FROM employees WHERE phone = $1 AND deleted_at IS NULL AND id <> $2", [phone, id]);
      if (phoneCheck.rows.length > 0) {
        return res.status(409).json({ message: "An employee with this phone number already exists" });
      }
    }

    // Resolve department
    let resolvedDeptId = departmentId || null;
    if (!resolvedDeptId && department) {
      const deptCheck = await pool.query(
        "SELECT id FROM departments WHERE name = $1 AND deleted_at IS NULL",
        [department]
      );
      if (deptCheck.rows.length > 0) {
        resolvedDeptId = deptCheck.rows[0].id;
      }
    }

    const updated = await empRepo.update(id, {
      first_name: firstName || existing.first_name,
      last_name: lastName || existing.last_name,
      employee_id: employeeId || existing.employee_id,
      email: email || existing.email,
      phone: phone || existing.phone,
      department_id: resolvedDeptId !== undefined ? resolvedDeptId : existing.department_id,
      designation: designation || existing.designation,
      joining_date: joiningDate ? new Date(joiningDate) : existing.joining_date,
      status: status || existing.status,
    });

    res.json(updated);
  } catch (error) {
    console.error("Update employee failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// DELETE soft delete employee
router.delete("/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  try {
    const existing = await empRepo.findById(id);
    if (!existing) {
      return res.status(404).json({ message: "Employee not found" });
    }

    // Security Check: HR Admin cannot manage Super Admin
    if (req.user?.role === "HR_ADMIN" || req.user?.role === "HR") {
      if (existing.user_id) {
        const targetUserRolesRes = await pool.query(
          `SELECT r.name FROM roles r 
           JOIN user_roles ur ON r.id = ur.role_id 
           WHERE ur.user_id = $1`,
          [existing.user_id]
        );
        const rolesList = targetUserRolesRes.rows.map((r: any) => r.name);
        if (rolesList.includes("SUPER_ADMIN") || rolesList.includes("ADMIN")) {
          return res.status(403).json({ message: "Access Denied: HR Admin cannot manage Super Admin" });
        }
      }
    }

    const success = await empRepo.deleteSoft(id);
    if (!success) {
      return res.status(404).json({ message: "Employee not found or already deleted" });
    }
    res.json({ message: "Employee soft-deleted successfully" });
  } catch (error) {
    console.error("Delete employee failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// POST restore employee
router.post("/:id/restore", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  try {
    const success = await empRepo.restore(id);
    if (!success) {
      return res.status(404).json({ message: "Employee not found or not deleted" });
    }
    res.json({ message: "Employee restored successfully" });
  } catch (error) {
    console.error("Restore employee failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// GET employee by ID
router.get("/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { id } = req.params;
  try {
    const empRes = await pool.query(
      `SELECT e.*, d.name as department_name 
       FROM employees e 
       LEFT JOIN departments d ON e.department_id = d.id 
       WHERE e.id = $1 AND e.deleted_at IS NULL`,
      [id]
    );

    if (empRes.rows.length === 0) {
      return res.status(404).json({ message: "Employee not found" });
    }

    const emp = empRes.rows[0];

    // Security Check: Standard employees / interns can only view their OWN profile
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      if (req.user.email !== emp.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only view their own profile" });
      }
    }

    // Fetch emergency contacts
    const contactRes = await pool.query(
      "SELECT name, relationship, phone FROM emergency_contacts WHERE employee_id = $1 AND deleted_at IS NULL LIMIT 1",
      [id]
    );
    const contact = contactRes.rows[0] || { name: "N/A", relationship: "N/A", phone: "N/A" };

    const profile = {
      id: emp.id,
      employeeId: emp.employee_id,
      name: `${emp.first_name} ${emp.last_name}`,
      department: emp.department_name || "Unassigned",
      designation: emp.designation,
      email: emp.email,
      phone: emp.phone || "N/A",
      status: emp.status,
      personalDetails: {
        firstName: emp.first_name,
        lastName: emp.last_name,
        dob: "1990-01-01",
        gender: "Male",
        maritalStatus: "Single",
        nationality: "Indian",
        bloodGroup: "O+",
        emergencyContact: {
          name: contact.name,
          relationship: contact.relationship,
          phone: contact.phone,
        },
      },
      jobDetails: {
        joiningDate: emp.joining_date ? emp.joining_date.toISOString().split("T")[0] : "",
        employeeType: "Full-Time Permanent",
        location: "HQ Office",
        reportingManager: {
          name: "Manager User",
          designation: "Director",
          email: "manager@company.com",
        },
      },
    };

    res.json(profile);
  } catch (error) {
    console.error("Fetch employee profile failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// GET departments
router.get("/departments", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query("SELECT id, name, code FROM departments WHERE deleted_at IS NULL");
    res.json(result.rows);
  } catch (error) {
    console.error("Fetch departments failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

export default router;
