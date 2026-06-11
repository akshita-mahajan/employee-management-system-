import { Router, Request, Response } from "express";
import pool from "../config/database.js";

const router = Router();

router.post("/login", async (req: Request, res: Response): Promise<any> => {
  const { email, password } = req.body;

  try {
    // Find user by email
    const userRes = await pool.query(
      "SELECT * FROM users WHERE email = $1 AND deleted_at IS NULL",
      [email]
    );

    if (userRes.rowCount === 0) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    const user = userRes.rows[0];

    // Simple validation (in production, compare bcrypt hash)
    // Accept "password123" for admin@hrms.com or standard dummy hashes
    const isValid = (email === "admin@hrms.com" && password === "password123") || 
                    (email === "jane.miller@company.com" && password === "password123") ||
                    (email === "alice.vance@company.com" && password === "password123");

    if (!isValid) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // Fetch user role
    const roleRes = await pool.query(
      `SELECT r.name FROM roles r 
       JOIN user_roles ur ON r.id = ur.role_id 
       WHERE ur.user_id = $1`,
      [user.id]
    );

    const roleName = roleRes.rows[0]?.name || "EMPLOYEE";

    // Fetch employee display details
    const empRes = await pool.query(
      "SELECT first_name, last_name FROM employees WHERE user_id = $1",
      [user.id]
    );
    const emp = empRes.rows[0];
    const name = emp ? `${emp.first_name} ${emp.last_name}` : "HR User";

    return res.json({
      token: "mock_jwt_access_token",
      user: {
        id: user.id,
        name,
        email: user.email,
        role: roleName,
      }
    });

  } catch (error) {
    console.error("Login route failed:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
});

router.get("/me", (req: Request, res: Response) => {
  // Mock validation for auth interceptors
  return res.json({
    id: "b2a4a31c-b631-41ee-a83d-6b5dfef6e901",
    name: "John Admin",
    email: "admin@hrms.com",
    role: "ADMIN"
  });
});

export default router;
