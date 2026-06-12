import { Router, Response } from "express";
import pool from "../config/database.js";
import { checkRole, AuthenticatedRequest } from "../middleware/rbacMiddleware.js";

const router = Router();

// Apply checkRole to all reporting routes
router.use(checkRole(["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "AUDITOR"]));

// 1. GET /api/reports/employees - employee metrics and trends
router.get("/employees", async (req: AuthenticatedRequest, res: Response) => {
  const { departmentId, teamId, status, startDate, endDate } = req.query;

  try {
    let whereClause = "e.deleted_at IS NULL";
    const params: any[] = [];

    if (departmentId) {
      params.push(departmentId);
      whereClause += ` AND e.department_id = $${params.length}`;
    }
    if (status) {
      params.push(status);
      whereClause += ` AND e.status = $${params.length}`;
    }
    if (startDate) {
      params.push(startDate);
      whereClause += ` AND e.joining_date >= $${params.length}`;
    }
    if (endDate) {
      params.push(endDate);
      whereClause += ` AND e.joining_date <= $${params.length}`;
    }
    if (teamId) {
      params.push(teamId);
      whereClause += ` AND e.id IN (SELECT employee_id FROM team_members WHERE team_id = $${params.length})`;
    }

    // A. Headcount by Department
    const deptDistribution = await pool.query(
      `SELECT d.name, COUNT(e.id)::integer as value
       FROM employees e
       LEFT JOIN departments d ON e.department_id = d.id
       WHERE ${whereClause} AND d.deleted_at IS NULL
       GROUP BY d.name`,
      params
    );

    // B. Employee Status Breakdown
    const statusBreakdown = await pool.query(
      `SELECT e.status as name, COUNT(e.id)::integer as value
       FROM employees e
       WHERE ${whereClause}
       GROUP BY e.status`,
      params
    );

    // C. Hire Trend (past 12 months)
    const hireTrend = await pool.query(
      `SELECT TO_CHAR(date_series, 'Mon YYYY') as month,
              COALESCE(
                (SELECT COUNT(*) FROM employees e 
                 WHERE DATE_TRUNC('month', e.joining_date) = DATE_TRUNC('month', date_series) 
                   AND ${whereClause.replace(/e\./g, "e.")}), 
                0
              )::integer as new_hires
       FROM GENERATE_SERIES(
         CURRENT_DATE - INTERVAL '11 months',
         CURRENT_DATE,
         '1 month'::interval
       ) date_series
       ORDER BY date_series ASC`,
      params
    );

    res.json({
      departmentDistribution: deptDistribution.rows,
      statusDistribution: statusBreakdown.rows,
      workforceGrowth: hireTrend.rows,
    });
  } catch (error) {
    console.error("Employee reports error:", error);
    res.status(500).json({ message: "Error loading employee reports" });
  }
});

// 2. GET /api/reports/payroll - payroll metrics
router.get("/payroll", async (req: AuthenticatedRequest, res: Response) => {
  const { departmentId, year, month } = req.query;

  try {
    let whereClause = "p.deleted_at IS NULL";
    const params: any[] = [];

    if (departmentId) {
      params.push(departmentId);
      whereClause += ` AND e.department_id = $${params.length}`;
    }
    if (year) {
      params.push(`${year}%`);
      whereClause += ` AND pr.billing_month LIKE $${params.length}`;
    }

    // A. Monthly Payout vs Budget
    const payrollTrend = await pool.query(
      `SELECT 
         pr.billing_month as month,
         SUM(p.net_pay)::double precision as actual_paid,
         (SELECT SUM(budget) FROM departments WHERE deleted_at IS NULL)::double precision as total_budget
       FROM payslips p
       JOIN payroll_runs pr ON p.payroll_run_id = pr.id
       JOIN employees e ON p.employee_id = e.id
       WHERE ${whereClause}
       GROUP BY pr.billing_month, pr.created_at
       ORDER BY pr.created_at ASC`,
      params
    );

    // B. Payroll Salary Brackets Breakdown
    const salaryDistribution = await pool.query(
      `SELECT 
         COUNT(CASE WHEN base_salary < 30000 THEN 1 END)::integer as bracket_low,
         COUNT(CASE WHEN base_salary >= 30000 AND base_salary < 70000 THEN 1 END)::integer as bracket_mid,
         COUNT(CASE WHEN base_salary >= 70000 AND base_salary < 150000 THEN 1 END)::integer as bracket_high,
         COUNT(CASE WHEN base_salary >= 150000 THEN 1 END)::integer as bracket_exec
       FROM salary_structures ss
       JOIN employees e ON ss.employee_id = e.id
       WHERE ss.deleted_at IS NULL ${departmentId ? ` AND e.department_id = $1` : ""}`,
      departmentId ? [departmentId] : []
    );

    res.json({
      payrollTrend: payrollTrend.rows,
      salaryDistribution: salaryDistribution.rows[0] || { bracket_low: 0, bracket_mid: 0, bracket_high: 0, bracket_exec: 0 },
    });
  } catch (error) {
    console.error("Payroll reports error:", error);
    res.status(500).json({ message: "Error loading payroll reports" });
  }
});

// 3. GET /api/reports/attendance - attendance metrics
router.get("/attendance", async (req: AuthenticatedRequest, res: Response) => {
  const { departmentId, teamId, startDate, endDate } = req.query;

  try {
    let whereClause = "a.deleted_at IS NULL";
    const params: any[] = [];

    if (departmentId) {
      params.push(departmentId);
      whereClause += ` AND e.department_id = $${params.length}`;
    }
    if (startDate) {
      params.push(startDate);
      whereClause += ` AND a.date >= $${params.length}`;
    }
    if (endDate) {
      params.push(endDate);
      whereClause += ` AND a.date <= $${params.length}`;
    }
    if (teamId) {
      params.push(teamId);
      whereClause += ` AND e.id IN (SELECT employee_id FROM team_members WHERE team_id = $${params.length})`;
    }

    // A. Weekly Attendance Rate (Mon-Fri)
    const attendanceTrend = await pool.query(
      `SELECT 
         TO_CHAR(a.date, 'Dy') as name,
         COALESCE(ROUND((COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0), 1), 0.0)::double precision as attendance
       FROM attendance a
       JOIN employees e ON a.employee_id = e.id
       WHERE ${whereClause} AND TO_CHAR(a.date, 'ID') IN ('1','2','3','4','5')
       GROUP BY TO_CHAR(a.date, 'Dy'), TO_CHAR(a.date, 'ID')
       ORDER BY TO_CHAR(a.date, 'ID') ASC`,
      params
    );

    res.json({
      attendanceTrend: attendanceTrend.rows,
    });
  } catch (error) {
    console.error("Attendance reports error:", error);
    res.status(500).json({ message: "Error loading attendance reports" });
  }
});

// 4. GET /api/reports/dashboard - dashboard summary
router.get("/dashboard", async (req: AuthenticatedRequest, res: Response) => {
  const { departmentId } = req.query;

  try {
    const activeEmpRes = await pool.query("SELECT COUNT(*) as count FROM employees WHERE deleted_at IS NULL");
    const activeCount = parseInt(activeEmpRes.rows[0].count);

    const payrollRes = await pool.query("SELECT COALESCE(SUM(net_pay), 0) as paid FROM payslips WHERE deleted_at IS NULL");
    const paidPayroll = parseFloat(payrollRes.rows[0].paid);

    const attRes = await pool.query("SELECT COALESCE(ROUND((COUNT(CASE WHEN status = 'PRESENT' THEN 1 END) * 100.0) / NULLIF(COUNT(*), 0), 1), 0.0) as rate FROM attendance WHERE deleted_at IS NULL");
    const attRate = parseFloat(attRes.rows[0].rate);

    // Query exports logs
    const exportsRes = await pool.query(
      `SELECT id, name, category, file_path as scope, TO_CHAR(created_at, 'YYYY-MM-DD') as "createdDate", file_format as "fileFormat" 
       FROM report_exports 
       ORDER BY created_at DESC LIMIT 50`
    );

    res.json({
      kpis: {
        totalEmployees: activeCount,
        totalPayroll: paidPayroll,
        attendanceRate: attRate,
      },
      reportsList: exportsRes.rows,
    });
  } catch (error) {
    console.error("Dashboard reports error:", error);
    res.status(500).json({ message: "Error loading dashboard reports" });
  }
});

// 5. POST /api/reports/generate - generate and log custom report
router.post("/generate", async (req: AuthenticatedRequest, res: Response) => {
  const { name, category, fileFormat, scope } = req.body;
  if (!name || !category || !fileFormat) {
    return res.status(400).json({ message: "Name, category and fileFormat are required" });
  }

  try {
    const result = await pool.query(
      `INSERT INTO report_exports (name, category, file_path, file_format, created_by) 
       VALUES ($1, $2, $3, $4, $5) RETURNING id, name, category, file_path as scope, TO_CHAR(created_at, 'YYYY-MM-DD') as "createdDate", file_format as "fileFormat"`,
      [name, category, scope || "Organization-wide", fileFormat, req.user?.id || null]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Generate report error:", error);
    res.status(500).json({ message: "Error generating report log" });
  }
});

export default router;
