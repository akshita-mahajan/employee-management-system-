import { Request, Response, NextFunction } from "express";
import pool from "../config/database.js";

// Extend Request interface to include user info
export interface AuthenticatedRequest extends Request {
  user?: {
    id: string;
    email: string;
    role: string;
  };
}

export const checkRole = (allowedRoles: string[]) => {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction): Promise<any> => {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.status(401).json({ message: "No token provided" });
    }

    const email = authHeader.split(" ")[1];
    if (!email) {
      return res.status(401).json({ message: "Invalid authorization header format" });
    }

    try {
      // Find active user
      const userRes = await pool.query(
        "SELECT id, email, is_active FROM users WHERE email = $1 AND deleted_at IS NULL",
        [email]
      );

      if (userRes.rowCount === 0 || !userRes.rows[0].is_active) {
        return res.status(401).json({ message: "User not found or inactive" });
      }

      const user = userRes.rows[0];

      // Fetch roles
      const roleRes = await pool.query(
        `SELECT r.name FROM roles r 
         JOIN user_roles ur ON r.id = ur.role_id 
         WHERE ur.user_id = $1`,
        [user.id]
      );

      const userRoles = roleRes.rows.map((row: any) => row.name.toUpperCase());
      
      // If user has SUPER_ADMIN or ADMIN role, always allow unrestricted access
      const hasSuperAccess = userRoles.includes("SUPER_ADMIN") || userRoles.includes("ADMIN");
      
      if (hasSuperAccess) {
        req.user = {
          id: user.id,
          email: user.email,
          role: userRoles.includes("SUPER_ADMIN") ? "SUPER_ADMIN" : "ADMIN",
        };
        return next();
      }

      // Check if user has at least one of the allowed roles
      const hasPermission = allowedRoles.some((role) => userRoles.includes(role.toUpperCase()));

      if (!hasPermission) {
        // Return 403 Forbidden for unauthorized access as requested
        return res.status(403).json({ message: "Access Denied: Insufficient Permissions" });
      }

      req.user = {
        id: user.id,
        email: user.email,
        role: userRoles[0] || "EMPLOYEE",
      };

      next();
    } catch (error) {
      console.error("RBAC Middleware Error:", error);
      return res.status(500).json({ message: "Internal Server Error in Authorization" });
    }
  };
};
