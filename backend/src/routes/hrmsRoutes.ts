import { Router, Request, Response } from "express";
import pool from "../config/database.js";

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
router.get("/departments", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT d.*, e.first_name || ' ' || e.last_name as manager_name 
       FROM departments d 
       LEFT JOIN employees e ON d.manager_id = e.id 
       WHERE d.deleted_at IS NULL`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading departments" });
  }
});

router.post("/departments", async (req, res): Promise<any> => {
  const { name, code, description, managerId, budget } = req.body;
  try {
    const checkCode = await pool.query("SELECT 1 FROM departments WHERE code = $1 AND deleted_at IS NULL", [code]);
    if (checkCode.rows.length > 0) {
      return res.status(400).json({ message: "Department code already exists" });
    }
    const result = await pool.query(
      `INSERT INTO departments (name, code, description, manager_id, budget) 
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [name, code, description, managerId || null, budget || 0.00]
    );
    await logAudit(null, "INSERT", "Department", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error creating department" });
  }
});

// -------------------------------------------------------------
// 2. TEAMS
// -------------------------------------------------------------
router.get("/teams", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT t.*, d.name as department_name, e.first_name || ' ' || e.last_name as lead_name 
       FROM teams t 
       LEFT JOIN departments d ON t.department_id = d.id 
       LEFT JOIN employees e ON t.team_lead_id = e.id 
       WHERE t.deleted_at IS NULL`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading teams" });
  }
});

router.post("/teams", async (req, res): Promise<any> => {
  const { name, code, departmentId, teamLeadId } = req.body;
  try {
    const checkCode = await pool.query("SELECT 1 FROM teams WHERE code = $1 AND deleted_at IS NULL", [code]);
    if (checkCode.rows.length > 0) {
      return res.status(400).json({ message: "Team code already exists" });
    }
    const result = await pool.query(
      `INSERT INTO teams (name, code, department_id, team_lead_id) 
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [name, code, departmentId, teamLeadId || null]
    );
    await logAudit(null, "INSERT", "Team", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error creating team" });
  }
});

// -------------------------------------------------------------
// 3. ATTENDANCE
// -------------------------------------------------------------
router.get("/attendance", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT a.*, e.first_name || ' ' || e.last_name as employee_name, 
              e.employee_id, al.check_in, al.check_out, al.overtime_mins, al.is_late
       FROM attendance a
       JOIN employees e ON a.employee_id = e.id
       LEFT JOIN attendance_logs al ON a.id = al.attendance_id
       WHERE a.deleted_at IS NULL
       ORDER BY a.date DESC`
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading attendance logs" });
  }
});

router.post("/attendance/checkin", async (req, res): Promise<any> => {
  const { employeeId, date, status } = req.body;
  try {
    const attRes = await pool.query(
      `INSERT INTO attendance (employee_id, date, status) 
       VALUES ($1, $2, $3) 
       ON CONFLICT (employee_id, date) DO UPDATE SET status = EXCLUDED.status, updated_at = CURRENT_TIMESTAMP
       RETURNING *`,
      [employeeId, date || new Date().toISOString().split("T")[0], status || "PRESENT"]
    );
    
    const attendanceId = attRes.rows[0].id;
    
    const logRes = await pool.query(
      `INSERT INTO attendance_logs (attendance_id, check_in) 
       VALUES ($1, CURRENT_TIMESTAMP) RETURNING *`,
      [attendanceId]
    );
    
    await logAudit(null, "CHECK_IN", "Attendance", null, { attendance: attRes.rows[0], log: logRes.rows[0] });
    res.status(201).json({ attendance: attRes.rows[0], log: logRes.rows[0] });
  } catch (error) {
    res.status(500).json({ message: "Error executing check-in" });
  }
});

// -------------------------------------------------------------
// 4. LEAVE MANAGEMENT
// -------------------------------------------------------------
router.get("/leaves", async (req, res) => {
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

router.get("/leaves/balances/:employeeId", async (req, res) => {
  try {
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

router.post("/leaves", async (req, res): Promise<any> => {
  const { employeeId, leaveTypeId, startDate, endDate, reason } = req.body;
  try {
    const result = await pool.query(
      `INSERT INTO leave_requests (employee_id, leave_type_id, start_date, end_date, reason, status) 
       VALUES ($1, $2, $3, $4, $5, 'PENDING') RETURNING *`,
      [employeeId, leaveTypeId, startDate, endDate, reason]
    );
    await logAudit(null, "INSERT", "LeaveRequest", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error submitting leave request" });
  }
});

router.put("/leaves/:id/status", async (req, res): Promise<any> => {
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

    // If approved, update leave balance
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

    await logAudit(null, "UPDATE_STATUS", "LeaveRequest", checkReq.rows[0], result.rows[0]);
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error updating leave status" });
  }
});

// -------------------------------------------------------------
// 5. ASSETS
// -------------------------------------------------------------
router.get("/assets", async (req, res) => {
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

router.post("/assets", async (req, res): Promise<any> => {
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
    await logAudit(null, "INSERT", "Asset", null, result.rows[0]);
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: "Error creating asset" });
  }
});

router.post("/assets/:id/assign", async (req, res): Promise<any> => {
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

    await logAudit(null, "ASSIGN", "Asset", checkAsset.rows[0], { employeeId });
    res.json({ success: true, message: "Asset assigned successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error assigning asset" });
  }
});

router.post("/assets/:id/return", async (req, res): Promise<any> => {
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

    await logAudit(null, "RETURN", "Asset", checkAsset.rows[0], { status: "Available" });
    res.json({ success: true, message: "Asset returned successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error returning asset" });
  }
});

// -------------------------------------------------------------
// 6. PAYROLL
// -------------------------------------------------------------
router.get("/payroll/runs", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM payroll_runs WHERE deleted_at IS NULL ORDER BY created_at DESC");
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ message: "Error loading payroll runs" });
  }
});

router.get("/payroll/payslips", async (req, res) => {
  try {
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
router.get("/notifications", async (req, res) => {
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
router.get("/audit-logs", async (req, res) => {
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

export default router;
