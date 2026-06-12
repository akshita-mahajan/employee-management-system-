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

    // Password validation: accept password123 or dummy hashes
    const isValid = password === "password123" || password === "farmhouse@123";

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
      token: user.email, // Use email as mock bearer token for simple dynamic resolution
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

router.get("/me", async (req: Request, res: Response): Promise<any> => {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ message: "No token provided" });
  }

  const email = authHeader.split(" ")[1];
  try {
    const userRes = await pool.query("SELECT * FROM users WHERE email = $1 AND deleted_at IS NULL", [email]);
    if (userRes.rowCount === 0) {
      return res.status(401).json({ message: "Invalid session token" });
    }

    const user = userRes.rows[0];
    const roleRes = await pool.query(
      `SELECT r.name FROM roles r 
       JOIN user_roles ur ON r.id = ur.role_id 
       WHERE ur.user_id = $1`,
      [user.id]
    );
    const roleName = roleRes.rows[0]?.name || "EMPLOYEE";

    const empRes = await pool.query(
      "SELECT first_name, last_name FROM employees WHERE user_id = $1",
      [user.id]
    );
    const emp = empRes.rows[0];
    const name = emp ? `${emp.first_name} ${emp.last_name}` : "HR User";

    return res.json({
      id: user.id,
      name,
      email: user.email,
      role: roleName,
    });
  } catch (error) {
    console.error("Fetch me failed:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

export default router;
