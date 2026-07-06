import { Router, Response } from "express";
import pool from "../config/database.js";
import { checkRole, AuthenticatedRequest } from "../middleware/rbacMiddleware.js";

const router = Router();

// Helper to log audit actions
const logAudit = async (userId: string | null, action: string, module: string, oldVal: any, newVal: any) => {
  try {
    await pool.query(
      `INSERT INTO audit_logs (user_id, action, module, old_values, new_values) 
       VALUES ($1, $2, $3, $4, $5)`,
      [userId, action, module, oldVal ? JSON.stringify(oldVal) : null, newVal ? JSON.stringify(newVal) : null]
    );
  } catch (err) {
    console.error("Audit log failed:", err);
  }
};

// -------------------------------------------------------------
// 1. DEPARTMENTS
// -------------------------------------------------------------
router.get("/departments", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT d.*, 
              e.first_name || ' ' || e.last_name as manager_name,
              (SELECT COUNT(*) FROM employees WHERE department_id = d.id AND deleted_at IS NULL) as employee_count
       FROM departments d 
       LEFT JOIN employees e ON d.manager_id = e.id 
       WHERE d.deleted_at IS NULL
       ORDER BY d.created_at DESC`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading departments" });
  }
});

router.post("/departments", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { name, code, description, managerId, budget } = req.body;
  if (!name) {
    return res.status(400).json({ message: "Department name is required" });
  }

  try {
    const checkName = await pool.query("SELECT 1 FROM departments WHERE LOWER(name) = LOWER($1) AND deleted_at IS NULL", [name]);
    if (checkName.rows.length > 0) {
      return res.status(400).json({ message: "Department name already exists" });
    }

    let resolvedCode = code;
    if (!resolvedCode) {
      const initials = name
        .split(" ")
        .map((word: string) => word[0])
        .join("")
        .toUpperCase()
        .replace(/[^A-Z]/g, "");
      
      resolvedCode = initials || "DEPT";
      
      let uniqueCode = resolvedCode;
      let suffix = 1;
      while (true) {
        const check = await pool.query("SELECT 1 FROM departments WHERE code = $1 AND deleted_at IS NULL", [uniqueCode]);
        if (check.rows.length === 0) {
          resolvedCode = uniqueCode;
          break;
        }
        uniqueCode = `${resolvedCode}${suffix}`;
        suffix++;
      }
    } else {
      const checkCode = await pool.query("SELECT 1 FROM departments WHERE code = $1 AND deleted_at IS NULL", [resolvedCode]);
      if (checkCode.rows.length > 0) {
        return res.status(400).json({ message: "Department code already exists" });
      }
    }

    const result = await pool.query(
      `INSERT INTO departments (name, code, description, manager_id, budget) 
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [name, resolvedCode, description, managerId || null, budget || 0.00]
    );
    await logAudit(req.user?.id || null, "INSERT", "Department", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Create department error:", error);
    res.status(500).json({ message: "Error creating department" });
  }
});

router.put("/departments/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  const { name, code, description, managerId, budget } = req.body;

  if (!name) {
    return res.status(400).json({ message: "Department name is required" });
  }

  try {
    const existing = await pool.query("SELECT * FROM departments WHERE id = $1 AND deleted_at IS NULL", [id]);
    if (existing.rows.length === 0) {
      return res.status(404).json({ message: "Department not found" });
    }

    const checkName = await pool.query(
      "SELECT 1 FROM departments WHERE LOWER(name) = LOWER($1) AND deleted_at IS NULL AND id <> $2",
      [name, id]
    );
    if (checkName.rows.length > 0) {
      return res.status(400).json({ message: "Another department with this name already exists" });
    }

    if (code) {
      const checkCode = await pool.query(
        "SELECT 1 FROM departments WHERE code = $1 AND deleted_at IS NULL AND id <> $2",
        [code, id]
      );
      if (checkCode.rows.length > 0) {
        return res.status(400).json({ message: "Another department with this code already exists" });
      }
    }

    const result = await pool.query(
      `UPDATE departments 
       SET name = $1, code = COALESCE($2, code), description = $3, manager_id = $4, budget = $5, updated_at = CURRENT_TIMESTAMP
       WHERE id = $6 AND deleted_at IS NULL RETURNING *`,
      [name, code || null, description, managerId || null, budget || 0.00, id]
    );

    await logAudit(req.user?.id || null, "UPDATE", "Department", existing.rows[0], result.rows[0]);
    res.json(result.rows[0]);
  } catch (error) {
    console.error("Update department error:", error);
    res.status(500).json({ message: "Error updating department" });
  }
});

router.delete("/departments/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  try {
    const existing = await pool.query("SELECT * FROM departments WHERE id = $1 AND deleted_at IS NULL", [id]);
    if (existing.rows.length === 0) {
      return res.status(404).json({ message: "Department not found" });
    }

    const checkEmp = await pool.query("SELECT COUNT(*) as count FROM employees WHERE department_id = $1 AND deleted_at IS NULL", [id]);
    const empCount = parseInt(checkEmp.rows[0].count);
    if (empCount > 0) {
      return res.status(400).json({ 
        message: `Cannot delete department because it has ${empCount} active employee(s) assigned. Please transfer them to another department first.` 
      });
    }

    const checkTeams = await pool.query("SELECT COUNT(*) as count FROM teams WHERE department_id = $1 AND deleted_at IS NULL", [id]);
    const teamCount = parseInt(checkTeams.rows[0].count);
    if (teamCount > 0) {
      return res.status(400).json({ 
        message: `Cannot delete department because it has ${teamCount} active team(s) assigned. Please reassign or delete the teams first.` 
      });
    }

    await pool.query("UPDATE departments SET deleted_at = CURRENT_TIMESTAMP WHERE id = $1", [id]);
    await logAudit(req.user?.id || null, "DELETE", "Department", existing.rows[0], { deleted_at: new Date() });
    res.json({ message: "Department soft-deleted successfully" });
  } catch (error) {
    console.error("Delete department error:", error);
    res.status(500).json({ message: "Error deleting department" });
  }
});

router.post("/departments/:id/restore", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id as string;
  try {
    const check = await pool.query("SELECT * FROM departments WHERE id = $1 AND deleted_at IS NOT NULL", [id]);
    if (check.rows.length === 0) {
      return res.status(404).json({ message: "Department not found or not deleted" });
    }

    await pool.query("UPDATE departments SET deleted_at = NULL, updated_at = CURRENT_TIMESTAMP WHERE id = $1", [id]);
    await logAudit(req.user?.id || null, "RESTORE", "Department", check.rows[0], { deleted_at: null });
    res.json({ message: "Department restored successfully" });
  } catch (error) {
    console.error("Restore department error:", error);
    res.status(500).json({ message: "Error restoring department" });
  }
});

// -------------------------------------------------------------
// 2. TEAMS
// -------------------------------------------------------------
router.get("/teams", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT t.*, d.name as department_name, 
              e.first_name || ' ' || e.last_name as lead_name,
              COALESCE(
                (SELECT json_agg(em.first_name || ' ' || em.last_name) 
                 FROM team_members tm 
                 JOIN employees em ON tm.employee_id = em.id 
                 WHERE tm.team_id = t.id AND em.deleted_at IS NULL), 
                '[]'::json
              ) as members_list,
              COALESCE(
                (SELECT json_agg(tm.employee_id)
                 FROM team_members tm
                 JOIN employees em ON tm.employee_id = em.id
                 WHERE tm.team_id = t.id AND em.deleted_at IS NULL),
                '[]'::json
              ) as member_ids,
              COALESCE(
                (SELECT COUNT(*) 
                 FROM team_members tm
                 JOIN employees em ON tm.employee_id = em.id
                 WHERE tm.team_id = t.id AND em.deleted_at IS NULL), 
                0
              ) as members_count
       FROM teams t 
       LEFT JOIN departments d ON t.department_id = d.id 
       LEFT JOIN employees e ON t.team_lead_id = e.id 
       WHERE t.deleted_at IS NULL
       ORDER BY t.created_at DESC`
    );
    res.json(result.rows);
  } catch (error) {
    console.error("Fetch teams failed:", error);
    res.status(500).json({ message: "Error loading teams" });
  }
});

router.post("/teams", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { name, code, departmentId, teamLeadId, memberIds } = req.body;
  if (!name || !departmentId) {
    return res.status(400).json({ message: "Team name and department are required" });
  }

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const checkDept = await client.query("SELECT 1 FROM departments WHERE id = $1 AND deleted_at IS NULL", [departmentId]);
    if (checkDept.rows.length === 0) {
      await client.query("ROLLBACK");
      return res.status(400).json({ message: "Selected department does not exist or has been deleted" });
    }

    let resolvedCode = code || `TEAM-${name.split(" ").map((w: string) => w[0]).join("").toUpperCase()}-${Math.floor(100 + Math.random() * 900)}`;
    const checkCode = await client.query("SELECT 1 FROM teams WHERE code = $1 AND deleted_at IS NULL", [resolvedCode]);
    if (checkCode.rows.length > 0) {
      await client.query("ROLLBACK");
      return res.status(400).json({ message: "Team code already exists" });
    }

    const teamRes = await client.query(
      `INSERT INTO teams (name, code, department_id, team_lead_id) 
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [name, resolvedCode, departmentId, teamLeadId || null]
    );
    const newTeam = teamRes.rows[0];

    if (memberIds && Array.isArray(memberIds)) {
      for (const empId of memberIds) {
        const checkDuplicate = await client.query(
          `SELECT t.name FROM team_members tm
           JOIN teams t ON tm.team_id = t.id
           WHERE tm.employee_id = $1 AND t.department_id = $2 AND t.deleted_at IS NULL`,
          [empId, departmentId]
        );
        if (checkDuplicate.rows.length > 0) {
          await client.query("ROLLBACK");
          return res.status(400).json({ 
            message: `Employee is already assigned to team '${checkDuplicate.rows[0].name}' in this department. Duplicate assignments are restricted.` 
          });
        }

        await client.query(
          "INSERT INTO team_members (team_id, employee_id) VALUES ($1, $2)",
          [newTeam.id, empId]
        );
      }
    }

    await client.query("COMMIT");
    await logAudit(req.user?.id || null, "INSERT", "Team", null, newTeam);
    res.status(201).json(newTeam);
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Create team error:", error);
    res.status(500).json({ message: "Error creating team" });
  } finally {
    client.release();
  }
});

router.put("/teams/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id;
  const { name, code, departmentId, teamLeadId, memberIds } = req.body;
  if (!name || !departmentId) {
    return res.status(400).json({ message: "Team name and department are required" });
  }

  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    const existing = await client.query("SELECT * FROM teams WHERE id = $1 AND deleted_at IS NULL", [id]);
    if (existing.rows.length === 0) {
      await client.query("ROLLBACK");
      return res.status(404).json({ message: "Team not found" });
    }

    const checkDept = await client.query("SELECT 1 FROM departments WHERE id = $1 AND deleted_at IS NULL", [departmentId]);
    if (checkDept.rows.length === 0) {
      await client.query("ROLLBACK");
      return res.status(400).json({ message: "Selected department does not exist or has been deleted" });
    }

    if (code) {
      const checkCode = await client.query("SELECT 1 FROM teams WHERE code = $1 AND deleted_at IS NULL AND id <> $2", [code, id]);
      if (checkCode.rows.length > 0) {
        await client.query("ROLLBACK");
        return res.status(400).json({ message: "Team code already exists for another team" });
      }
    }

    const teamRes = await client.query(
      `UPDATE teams 
       SET name = $1, code = COALESCE($2, code), department_id = $3, team_lead_id = $4, updated_at = CURRENT_TIMESTAMP
       WHERE id = $5 RETURNING *`,
      [name, code || null, departmentId, teamLeadId || null, id]
    );
    const updatedTeam = teamRes.rows[0];

    await client.query("DELETE FROM team_members WHERE team_id = $1", [id]);
    if (memberIds && Array.isArray(memberIds)) {
      for (const empId of memberIds) {
        const checkDuplicate = await client.query(
          `SELECT t.name FROM team_members tm
           JOIN teams t ON tm.team_id = t.id
           WHERE tm.employee_id = $1 AND t.department_id = $2 AND t.deleted_at IS NULL AND t.id <> $3`,
          [empId, departmentId, id]
        );
        if (checkDuplicate.rows.length > 0) {
          await client.query("ROLLBACK");
          return res.status(400).json({ 
            message: `Employee is already assigned to team '${checkDuplicate.rows[0].name}' in this department. Duplicate assignments are restricted.` 
          });
        }

        await client.query(
          "INSERT INTO team_members (team_id, employee_id) VALUES ($1, $2)",
          [id, empId]
        );
      }
    }

    await client.query("COMMIT");
    await logAudit(req.user?.id || null, "UPDATE", "Team", existing.rows[0], updatedTeam);
    res.json(updatedTeam);
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Update team error:", error);
    res.status(500).json({ message: "Error updating team" });
  } finally {
    client.release();
  }
});

router.delete("/teams/:id", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const id = req.params.id;
  try {
    const existing = await pool.query("SELECT * FROM teams WHERE id = $1 AND deleted_at IS NULL", [id]);
    if (existing.rows.length === 0) {
      return res.status(404).json({ message: "Team not found" });
    }

    await pool.query("UPDATE teams SET deleted_at = CURRENT_TIMESTAMP WHERE id = $1", [id]);
    await logAudit(req.user?.id || null, "DELETE", "Team", existing.rows[0], { deleted_at: new Date() });
    res.json({ message: "Team soft-deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting team" });
  }
});

// -------------------------------------------------------------
// 3. ATTENDANCE
// -------------------------------------------------------------
router.get("/attendance", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT a.*, e.first_name || ' ' || e.last_name as employee_name,
              al.check_in, al.check_out, al.overtime_mins, al.is_late
       FROM attendance a
       JOIN employees e ON a.employee_id = e.id
       LEFT JOIN attendance_logs al ON a.id = al.attendance_id
       WHERE a.deleted_at IS NULL
       ORDER BY a.date DESC, al.check_in DESC`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading attendance logs" });
  }
});

router.get("/attendance/:employeeId", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  try {
    // Security check: Employee can only see their own attendance logs
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const empCheck = await pool.query("SELECT email FROM employees WHERE id = $1", [req.params.employeeId]);
      if (empCheck.rows.length === 0 || empCheck.rows[0].email !== req.user.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only view their own attendance" });
      }
    }

    const result = await pool.query(
      `SELECT a.*, al.check_in, al.check_out, al.overtime_mins, al.is_late
       FROM attendance a
       LEFT JOIN attendance_logs al ON a.id = al.attendance_id
       WHERE a.employee_id = $1 AND a.deleted_at IS NULL
       ORDER BY a.date DESC`,
      [req.params.employeeId]
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading employee attendance" });
  }
});

router.post("/attendance/check-in", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { employeeId } = req.body;
  try {
    // Security check: Employee can only check-in for themselves
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const empCheck = await pool.query("SELECT email FROM employees WHERE id = $1", [employeeId]);
      if (empCheck.rows.length === 0 || empCheck.rows[0].email !== req.user.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only check-in for themselves" });
      }
    }

    const attRes = await pool.query(
      `INSERT INTO attendance (employee_id, date, status) 
       VALUES ($1, CURRENT_DATE, 'PRESENT') 
       ON CONFLICT (employee_id, date) DO UPDATE SET status = 'PRESENT', updated_at = CURRENT_TIMESTAMP
       RETURNING *`,
      [employeeId]
    );
    
    const attendanceId = attRes.rows[0].id;
    
    const logRes = await pool.query(
      `INSERT INTO attendance_logs (attendance_id, check_in) 
       VALUES ($1, CURRENT_TIMESTAMP) RETURNING *`,
      [attendanceId]
    );
    
    await logAudit(req.user?.id || null, "CHECK_IN", "Attendance", null, { attendance: attRes.rows[0], log: logRes.rows[0] });
    res.status(201).json({ attendance: attRes.rows[0], log: logRes.rows[0] });
  } catch (error) {
    res.status(500).json({ message: "Error executing check-in" });
  }
});

router.post("/attendance/check-out", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { employeeId } = req.body;
  try {
    // Security check: Employee can only check-out for themselves
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const empCheck = await pool.query("SELECT email FROM employees WHERE id = $1", [employeeId]);
      if (empCheck.rows.length === 0 || empCheck.rows[0].email !== req.user.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only check-out for themselves" });
      }
    }

    const attRes = await pool.query(
      "SELECT id FROM attendance WHERE employee_id = $1 AND date = CURRENT_DATE AND deleted_at IS NULL",
      [employeeId]
    );
    if (attRes.rows.length === 0) {
      return res.status(404).json({ message: "Check-in log not found for today" });
    }

    const attendanceId = attRes.rows[0].id;

    const logRes = await pool.query(
      `UPDATE attendance_logs 
       SET check_out = CURRENT_TIMESTAMP 
       WHERE attendance_id = $1 AND check_out IS NULL RETURNING *`,
      [attendanceId]
    );

    await logAudit(req.user?.id || null, "CHECK_OUT", "Attendance", null, { log: logRes.rows[0] });
    res.json({ success: true, log: logRes.rows[0] });
  } catch (error) {
    res.status(500).json({ message: "Error executing check-out" });
  }
});

// -------------------------------------------------------------
// 4. LEAVE MANAGEMENT
// -------------------------------------------------------------
router.get("/leaves", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT lr.*, e.first_name || ' ' || e.last_name as employee_name, lt.name as leave_type_name
       FROM leave_requests lr
       JOIN employees e ON lr.employee_id = e.id
       JOIN leave_types lt ON lr.leave_type_id = lt.id
       WHERE lr.deleted_at IS NULL
       ORDER BY lr.created_at DESC`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading leave requests" });
  }
});

router.get("/leaves/balances/:employeeId", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  try {
    // Security check: Employee can only view their own leave balances
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const empCheck = await pool.query("SELECT email FROM employees WHERE id = $1", [req.params.employeeId]);
      if (empCheck.rows.length === 0 || empCheck.rows[0].email !== req.user.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only view their own leave balances" });
      }
    }

    const result = await pool.query(
      `SELECT lb.*, lt.name as leave_type_name
       FROM leave_balances lb
       JOIN leave_types lt ON lb.leave_type_id = lt.id
       WHERE lb.employee_id = $1 AND lb.deleted_at IS NULL`,
      [req.params.employeeId]
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading leave balances" });
  }
});

router.post("/leaves", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { employeeId, leaveTypeId, startDate, endDate, reason } = req.body;
  try {
    // Security check: Employee can only submit leave requests for themselves
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const empCheck = await pool.query("SELECT email FROM employees WHERE id = $1", [employeeId]);
      if (empCheck.rows.length === 0 || empCheck.rows[0].email !== req.user.email) {
        return res.status(403).json({ message: "Access Denied: Employees can only request leaves for themselves" });
      }
    }

    const result = await pool.query(
      `INSERT INTO leave_requests (employee_id, leave_type_id, start_date, end_date, reason, status) 
       VALUES ($1, $2, $3, $4, $5, 'PENDING') RETURNING *`,
      [employeeId, leaveTypeId, startDate, endDate, reason]
    );
    await logAudit(req.user?.id || null, "INSERT", "LeaveRequest", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error submitting leave request" });
  }
});

router.put("/leaves/:id/status", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { status, approvedBy } = req.body;
  try {
    const checkReq = await pool.query("SELECT * FROM leave_requests WHERE id = $1", [req.params.id]);
    if (checkReq.rows.length === 0) {
      return res.status(404).json({ message: "Leave request not found" });
    }

    const result = await pool.query(
      `UPDATE leave_requests 
       SET status = $1, approved_by = $2, updated_at = CURRENT_TIMESTAMP 
       WHERE id = $3 RETURNING *`,
      [status, approvedBy || null, req.params.id]
    );

    if (status === "APPROVED") {
      const leave = result.rows[0];
      const start = new Date(leave.start_date);
      const end = new Date(leave.end_date);
      const days = Math.ceil((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)) + 1;

      await pool.query(
        `UPDATE leave_balances 
         SET used = used + $1, updated_at = CURRENT_TIMESTAMP
         WHERE employee_id = $2 AND leave_type_id = $3`,
        [days, leave.employee_id, leave.leave_type_id]
      );
    }

    await logAudit(req.user?.id || null, "UPDATE_STATUS", "LeaveRequest", checkReq.rows[0], result.rows[0]);
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error updating leave status" });
  }
});

// -------------------------------------------------------------
// 5. ASSETS
// -------------------------------------------------------------
router.get("/assets", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT a.*, c.name as category_name, 
              e.first_name || ' ' || e.last_name as assigned_to_name
       FROM assets a
       JOIN asset_categories c ON a.category_id = c.id
       LEFT JOIN asset_assignments aa ON a.id = aa.asset_id AND aa.returned_date IS NULL
       LEFT JOIN employees e ON aa.employee_id = e.id
       WHERE a.deleted_at IS NULL`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading assets" });
  }
});

router.post("/assets", checkRole(["SUPER_ADMIN", "ADMIN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { categoryId, name, code, value, status } = req.body;
  try {
    const checkCode = await pool.query("SELECT 1 FROM assets WHERE code = $1 AND deleted_at IS NULL", [code]);
    if (checkCode.rows.length > 0) {
      return res.status(400).json({ message: "Asset serial code already exists" });
    }
    const result = await pool.query(
      `INSERT INTO assets (category_id, name, code, value, status) 
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [categoryId, name, code, value || 0.00, status || "Available"]
    );
    await logAudit(req.user?.id || null, "INSERT", "Asset", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error creating asset" });
  }
});

router.post("/assets/:id/assign", checkRole(["SUPER_ADMIN", "ADMIN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { employeeId, notes } = req.body;
  const assetId = req.params.id;
  try {
    const checkAsset = await pool.query("SELECT * FROM assets WHERE id = $1 AND deleted_at IS NULL", [assetId]);
    if (checkAsset.rows.length === 0) {
      return res.status(404).json({ message: "Asset not found" });
    }

    await pool.query("UPDATE assets SET status = 'Assigned', updated_at = CURRENT_TIMESTAMP WHERE id = $1", [assetId]);
    await pool.query(
      `INSERT INTO asset_assignments (asset_id, employee_id, notes) 
       VALUES ($1, $2, $3)`,
      [assetId, employeeId, notes || null]
    );
    await pool.query(
      "INSERT INTO asset_history (asset_id, action, details) VALUES ($1, 'Assignment', $2)",
      [assetId, `Assigned to employee ${employeeId}`]
    );

    await logAudit(req.user?.id || null, "ASSIGN", "Asset", checkAsset.rows[0], { employeeId });
    res.json({ success: true, message: "Asset assigned successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error assigning asset" });
  }
});

router.post("/assets/:id/return", checkRole(["SUPER_ADMIN", "ADMIN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const assetId = req.params.id;
  try {
    const checkAsset = await pool.query("SELECT * FROM assets WHERE id = $1 AND deleted_at IS NULL", [assetId]);
    if (checkAsset.rows.length === 0) {
      return res.status(404).json({ message: "Asset not found" });
    }

    await pool.query("UPDATE assets SET status = 'Available', updated_at = CURRENT_TIMESTAMP WHERE id = $1", [assetId]);
    await pool.query(
      `UPDATE asset_assignments 
       SET returned_date = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP 
       WHERE asset_id = $1 AND returned_date IS NULL`,
      [assetId]
    );
    await pool.query(
      "INSERT INTO asset_history (asset_id, action, details) VALUES ($1, 'Return', 'Returned to warehouse available stock')",
      [assetId]
    );

    await logAudit(req.user?.id || null, "RETURN", "Asset", checkAsset.rows[0], { status: "Available" });
    res.json({ success: true, message: "Asset returned successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error returning asset" });
  }
});

// -------------------------------------------------------------
// 6. PAYROLL
// -------------------------------------------------------------
router.get("/payroll/runs", checkRole(["SUPER_ADMIN", "ADMIN", "PAYROLL_ADMIN", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT pr.*, 
              (SELECT COUNT(*)::integer FROM payslips WHERE payroll_run_id = pr.id) as employee_count
       FROM payroll_runs pr 
       WHERE pr.deleted_at IS NULL 
       ORDER BY pr.created_at DESC`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading payroll runs" });
  }
});

router.post("/payroll/runs", checkRole(["SUPER_ADMIN", "ADMIN", "PAYROLL_ADMIN"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { billingMonth } = req.body;
  if (!billingMonth) {
    return res.status(400).json({ message: "Billing month name is required" });
  }

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    // Check if payroll run already exists for this month
    const existing = await client.query("SELECT 1 FROM payroll_runs WHERE billing_month = $1 AND deleted_at IS NULL", [billingMonth]);
    if (existing.rows.length > 0) {
      await client.query("ROLLBACK");
      return res.status(400).json({ message: `Payroll has already been processed for ${billingMonth}` });
    }

    // Fetch active employees with their salary structures
    const employeesRes = await client.query(
      `SELECT e.id, ss.base_salary, ss.hra, ss.lta 
       FROM employees e
       JOIN salary_structures ss ON e.id = ss.employee_id
       WHERE e.status = 'ACTIVE' AND e.deleted_at IS NULL AND ss.deleted_at IS NULL`
    );

    if (employeesRes.rows.length === 0) {
      await client.query("ROLLBACK");
      return res.status(400).json({ message: "No active employees with configured salary structures found." });
    }

    // Insert new payroll run
    const payrollRunRes = await client.query(
      `INSERT INTO payroll_runs (billing_month, status, total_payout) 
       VALUES ($1, 'PROCESSED', 0.00) RETURNING *`,
      [billingMonth]
    );
    const newRun = payrollRunRes.rows[0];

    let totalPayout = 0;

    for (const emp of employeesRes.rows) {
      const base = parseFloat(emp.base_salary);
      const hra = parseFloat(emp.hra);
      const lta = parseFloat(emp.lta);
      
      const earnings = base + hra + lta;
      const pf = base * 0.12;
      const pt = 200.00;
      const netPay = earnings - (pf + pt);
      totalPayout += netPay;

      // Insert payslip
      const payslipRes = await client.query(
        `INSERT INTO payslips (payroll_run_id, employee_id, net_pay) 
         VALUES ($1, $2, $3) RETURNING id`,
        [newRun.id, emp.id, netPay]
      );
      const payslipId = payslipRes.rows[0].id;

      // Insert payroll components
      await client.query(
        `INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES 
         ($1, 'Basic Salary', 'EARNING', $2),
         ($1, 'House Rent Allowance (HRA)', 'EARNING', $3),
         ($1, 'Leave Travel Allowance (LTA)', 'EARNING', $4),
         ($1, 'Provident Fund (PF)', 'DEDUCTION', $5),
         ($1, 'Professional Tax', 'DEDUCTION', $6)`,
        [payslipId, base, hra, lta, pf, pt]
      );
    }

    // Update total payout
    await client.query(
      "UPDATE payroll_runs SET total_payout = $1 WHERE id = $2",
      [totalPayout, newRun.id]
    );

    newRun.total_payout = totalPayout;

    await client.query("COMMIT");
    await logAudit(req.user?.id || null, "INSERT", "PayrollRun", null, newRun);

    res.status(201).json(newRun);
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Run payroll failed:", error);
    res.status(500).json({ message: "Error running payroll cycle" });
  } finally {
    client.release();
  }
});

router.get("/payroll/payslips", checkRole(["SUPER_ADMIN", "ADMIN", "PAYROLL_ADMIN", "AUDITOR", "EMPLOYEE", "INTERN"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    // Security check: Employees and interns can only fetch their own payslips
    if (req.user?.role === "EMPLOYEE" || req.user?.role === "INTERN") {
      const result = await pool.query(
        `SELECT p.*, e.first_name || ' ' || e.last_name as employee_name, e.employee_id, pr.billing_month
         FROM payslips p
         JOIN employees e ON p.employee_id = e.id
         JOIN payroll_runs pr ON p.payroll_run_id = pr.id
         WHERE p.deleted_at IS NULL AND e.email = $1`,
        [req.user.email]
      );
      return res.json(result.rows);
    }

    const result = await pool.query(
      `SELECT p.*, e.first_name || ' ' || e.last_name as employee_name, e.employee_id, pr.billing_month
       FROM payslips p
       JOIN employees e ON p.employee_id = e.id
       JOIN payroll_runs pr ON p.payroll_run_id = pr.id
       WHERE p.deleted_at IS NULL`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading payslips" });
  }
});

// -------------------------------------------------------------
// 7. NOTIFICATIONS
// -------------------------------------------------------------
router.get("/notifications", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "PAYROLL_ADMIN", "MANAGER", "TEAM_LEAD", "EMPLOYEE", "INTERN", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query("SELECT * FROM notifications ORDER BY created_at DESC LIMIT 50");
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading notifications" });
  }
});

// -------------------------------------------------------------
// 8. AUDIT LOGS
// -------------------------------------------------------------
router.get("/audit-logs", checkRole(["SUPER_ADMIN", "ADMIN", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response) => {
  try {
    const result = await pool.query(
      `SELECT a.*, u.email as user_email 
       FROM audit_logs a 
       LEFT JOIN users u ON a.user_id = u.id 
       ORDER BY a.created_at DESC LIMIT 100`
      );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading audit logs" });
  }
});

// -------------------------------------------------------------
// 9. DASHBOARD BUSINESS INTELLIGENCE ANALYTICS
// -------------------------------------------------------------
router.get("/dashboard/analytics", checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "PAYROLL_ADMIN", "MANAGER", "TEAM_LEAD", "AUDITOR"]), async (req: AuthenticatedRequest, res: Response): Promise<any> => {
  const { departmentId, year, quarter } = req.query;

  try {
    const deptId = departmentId || null;

    // Helper for department filtering
    const deptFilter = deptId ? "AND department_id = $1" : "";
    const deptFilterEmp = deptId ? "AND e.department_id = $1" : "";
    const params = deptId ? [deptId] : [];

    const activeEmpRes = await pool.query(
      `SELECT COUNT(*) as count FROM employees WHERE deleted_at IS NULL ${deptFilter}`,
      params
    );
    const prevEmpRes = await pool.query(
      `SELECT COUNT(*) as count FROM employees WHERE deleted_at IS NULL AND created_at < DATE_TRUNC('month', CURRENT_DATE) ${deptFilter}`,
      params
    );
    
    const activeCount = parseInt(activeEmpRes.rows[0].count);
    const prevCount = parseInt(prevEmpRes.rows[0].count);
    const employeeGrowth = prevCount > 0 ? parseFloat(((activeCount - prevCount) * 100.0 / prevCount).toFixed(1)) : 0;

    const payrollRes = await pool.query(
      `SELECT COALESCE(SUM(p.net_pay), 0) as paid 
       FROM payslips p 
       JOIN employees e ON p.employee_id = e.id
       WHERE p.created_at >= DATE_TRUNC('month', CURRENT_DATE) AND p.deleted_at IS NULL ${deptFilterEmp}`,
      params
    );
    const prevPayrollRes = await pool.query(
      `SELECT COALESCE(SUM(p.net_pay), 0) as paid 
       FROM payslips p
       JOIN employees e ON p.employee_id = e.id
       WHERE p.created_at >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') 
         AND p.created_at < DATE_TRUNC('month', CURRENT_DATE) 
         AND p.deleted_at IS NULL ${deptFilterEmp}`,
      params
    );
    
    const paidPayroll = parseFloat(payrollRes.rows[0].paid);
    const prevPayroll = parseFloat(prevPayrollRes.rows[0].paid);
    const payrollVariance = prevPayroll > 0 ? parseFloat(((paidPayroll - prevPayroll) * 100.0 / prevPayroll).toFixed(1)) : 0;

    const attRes = await pool.query(
      `SELECT COALESCE(ROUND((COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0), 1), 0.0) as rate 
       FROM attendance a
       JOIN employees e ON a.employee_id = e.id
       WHERE a.date >= DATE_TRUNC('month', CURRENT_DATE) AND a.deleted_at IS NULL ${deptFilterEmp}`,
      params
    );
    const prevAttRes = await pool.query(
      `SELECT COALESCE(ROUND((COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0), 1), 0.0) as rate 
       FROM attendance a
       JOIN employees e ON a.employee_id = e.id
       WHERE a.date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') 
         AND a.date < DATE_TRUNC('month', CURRENT_DATE) 
         AND a.deleted_at IS NULL ${deptFilterEmp}`,
      params
    );
    
    const attRate = parseFloat(attRes.rows[0].rate);
    const prevAttRate = parseFloat(prevAttRes.rows[0].rate);
    const attGrowth = parseFloat((attRate - prevAttRate).toFixed(1));

    // Handle year/quarter logic for trend series
    const selectedYr = year ? parseInt(year as string) : new Date().getFullYear();
    let startDateStr = `${selectedYr}-01-01`;
    let endDateStr = `${selectedYr}-12-31`;

    if (quarter === "Q1") {
      startDateStr = `${selectedYr}-01-01`;
      endDateStr = `${selectedYr}-03-31`;
    } else if (quarter === "Q2") {
      startDateStr = `${selectedYr}-04-01`;
      endDateStr = `${selectedYr}-06-30`;
    } else if (quarter === "Q3") {
      startDateStr = `${selectedYr}-07-01`;
      endDateStr = `${selectedYr}-09-30`;
    } else if (quarter === "Q4") {
      startDateStr = `${selectedYr}-10-01`;
      endDateStr = `${selectedYr}-12-31`;
    }

    const trendRes = await pool.query(
      `SELECT 
         TO_CHAR(date_series, 'Mon YYYY') as month,
         COALESCE(
           (SELECT SUM(p.net_pay) 
            FROM payslips p 
            JOIN employees e ON p.employee_id = e.id
            WHERE DATE_TRUNC('month', p.created_at) = DATE_TRUNC('month', date_series) 
              AND p.deleted_at IS NULL ${deptFilterEmp}), 
           0
         )::double precision as actual_paid,
         COALESCE(
           (SELECT SUM(d.budget) 
            FROM departments d 
            WHERE d.deleted_at IS NULL ${deptId ? "AND d.id = $1" : ""}),
           0
         )::double precision as total_budget
       FROM GENERATE_SERIES(
         $${params.length + 1}::timestamp,
         $${params.length + 2}::timestamp,
         '1 month'::interval
       ) date_series
       ORDER BY date_series ASC`,
      [...params, startDateStr, endDateStr]
    );

    const deptDistRes = await pool.query(
      `SELECT 
         d.id,
         d.name,
         d.code,
         d.budget::double precision,
         COALESCE(e_mgr.first_name || ' ' || e_mgr.last_name, 'Unassigned') as manager_name,
         COUNT(e.id)::integer as employee_count,
         COALESCE(AVG(ss.base_salary + ss.hra + ss.lta), 0)::double precision as avg_salary,
         COALESCE(
           (SELECT ROUND((COUNT(CASE WHEN att.status = 'PRESENT' THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0), 1)
            FROM attendance att
            WHERE att.employee_id IN (SELECT id FROM employees WHERE department_id = d.id AND deleted_at IS NULL)
            AND att.date >= DATE_TRUNC('month', CURRENT_DATE)
            AND att.deleted_at IS NULL),
           0.0
         )::double precision as avg_attendance
       FROM departments d
       LEFT JOIN employees e_mgr ON d.manager_id = e_mgr.id
       LEFT JOIN employees e ON e.department_id = d.id AND e.deleted_at IS NULL
       LEFT JOIN salary_structures ss ON ss.employee_id = e.id AND ss.deleted_at IS NULL
       WHERE d.deleted_at IS NULL
       GROUP BY d.id, d.name, d.code, d.budget, e_mgr.first_name, e_mgr.last_name`
    );

    const salaryDistRes = await pool.query(
      `SELECT 
         COUNT(CASE WHEN base_salary < 30000 THEN 1 END)::integer as bracket_low,
         COUNT(CASE WHEN base_salary >= 30000 AND base_salary < 70000 THEN 1 END)::integer as bracket_mid,
         COUNT(CASE WHEN base_salary >= 70000 AND base_salary < 150000 THEN 1 END)::integer as bracket_high,
         COUNT(CASE WHEN base_salary >= 150000 THEN 1 END)::integer as bracket_exec
       FROM salary_structures ss
       JOIN employees e ON ss.employee_id = e.id
       WHERE ss.deleted_at IS NULL ${deptFilterEmp}`,
      params
    );

    const growthRes = await pool.query(
      `SELECT 
         TO_CHAR(date_series, 'Mon YYYY') as month,
         COALESCE(
           (SELECT COUNT(*) FROM employees e 
            WHERE DATE_TRUNC('month', e.joining_date) = DATE_TRUNC('month', date_series) 
              AND e.deleted_at IS NULL ${deptFilterEmp}),
           0
         )::integer as new_hires
       FROM GENERATE_SERIES(
         $${params.length + 1}::timestamp,
         $${params.length + 2}::timestamp,
         '1 month'::interval
       ) date_series
       ORDER BY date_series ASC`,
      [...params, startDateStr, endDateStr]
    );

    res.json({
      kpis: {
        totalEmployees: { value: activeCount, growth: employeeGrowth },
        totalPayroll: { value: paidPayroll, growth: payrollVariance },
        attendanceRate: { value: attRate, growth: attGrowth }
      },
      payrollTrend: trendRes.rows,
      departments: deptDistRes.rows,
      salaryDistribution: salaryDistRes.rows[0] || { bracket_low: 0, bracket_mid: 0, bracket_high: 0, bracket_exec: 0 },
      workforceGrowth: growthRes.rows
    });

  } catch (error) {
    console.error("Fetch analytics report failed:", error);
    res.status(500).json({ message: "Error loading business intelligence report" });
  }
});

export default router;
