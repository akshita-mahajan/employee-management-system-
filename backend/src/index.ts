import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes.js";
import employeeRoutes from "./routes/employeeRoutes.js";
import hrmsRoutes from "./routes/hrmsRoutes.js";

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors({
  origin: "http://localhost:5173", // Frontend Vite dev server port
  credentials: true,
}));

app.use(express.json());

// Load backend API endpoints
app.use("/api/auth", authRoutes);
app.use("/api/employees", employeeRoutes);
app.use("/api", hrmsRoutes);

app.get("/health", (req, res) => {
  res.json({ status: "healthy", timestamp: new Date() });
});

app.listen(PORT, () => {
  console.log(`Enterprise HRMS Server is listening on http://localhost:${PORT}`);
});
