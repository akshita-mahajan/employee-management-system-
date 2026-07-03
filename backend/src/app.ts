import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes.js";
import employeeRoutes from "./routes/employeeRoutes.js";
import hrmsRoutes from "./routes/hrmsRoutes.js";
import reportRoutes from "./routes/reportRoutes.js";
import pool from "./config/database.js";

const app = express();

app.use(
  cors({
    origin: "http://localhost:5173", // Frontend Vite dev server port
    credentials: true,
  })
);

app.use(express.json());

// Load backend API endpoints
app.use("/api/auth", authRoutes);
app.use("/api/employees", employeeRoutes);
app.use("/api/reports", reportRoutes);
app.use("/api", hrmsRoutes);

app.get(["/health", "/api/health"], (req, res) => {
  res.json({ status: "healthy", timestamp: new Date() });
});

export const seedRoles = async () => {
  try {
    await pool.query(`
      INSERT INTO roles (name, description) VALUES
      ('SUPER_ADMIN', 'Super Admin with full access'),
      ('HR_ADMIN', 'HR Admin with workforce management'),
      ('PAYROLL_ADMIN', 'Payroll administrator'),
      ('TEAM_LEAD', 'Team leader'),
      ('INTERN', 'Intern staff'),
      ('AUDITOR', 'Read only auditor')
      ON CONFLICT (name) DO NOTHING;
    `);
  } catch (err) {
    console.error("Failed to seed additional RBAC roles:", err);
  }
};

export default app;
