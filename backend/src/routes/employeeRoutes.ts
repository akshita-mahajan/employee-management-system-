import { Router, Request, Response } from "express";
import { EmployeeRepository } from "../repositories/EmployeeRepository.js";
import pool from "../config/database.js";

const router = Router();
const empRepo = new EmployeeRepository();

// GET all employees (paginated + filters)
router.get("/", async (req: Request, res: Response) => {
  const { page, limit, search, sortBy, sortOrder, status, departmentId } = req.query;

  try {
    const filters: any = {};
    if (status) filters.status = status;
    if (departmentId) filters.departmentId = departmentId;

    const result = await empRepo.findPaginated({
      page: page ? parseInt(page as string) : 1,
      limit: limit ? parseInt(limit as string) : 10,
      search: search as string,
      sortBy: sortBy as string,
      sortOrder: (sortOrder as "ASC" | "DESC") || "ASC",
      filters,
    });

    // Match output format to frontend
    // Frontend expects department as a string (name) instead of UUID.
    // Let's resolve department names for the response.
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
router.post("/", async (req: Request, res: Response): Promise<any> => {
  const { firstName, lastName, employeeId, email, phone, departmentId, department, designation, joiningDate, status } = req.body;

  if (!firstName || !lastName || !employeeId || !email) {
    return res.status(400).json({ message: "Required fields are missing" });
  }

  try {
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

// GET departments
router.get("/departments", async (req: Request, res: Response) => {
  try {
    const result = await pool.query("SELECT id, name, code FROM departments WHERE deleted_at IS NULL");
    res.json(result.rows);
  } catch (error) {
    console.error("Fetch departments failed:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

export default router;
