import { Pool } from "pg";
import * as dotenv from "dotenv";
import path from "path";

// Load environment variables from backend/.env file
dotenv.config({ path: path.join(__dirname, "../../.env") });

const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  port: parseInt(process.env.DB_PORT || "5432"),
  database: process.env.DB_NAME || "enterprise_hrms",
  user: process.env.DB_USER || "postgres",
  password: process.env.DB_PASSWORD || "password",
  max: 20, // max connections in pool
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

export const query = async (text: string, params?: any[]) => {
  const start = Date.now();
  const res = await pool.query(text, params);
  const duration = Date.now() - start;
  // Audit log standard query durations in development if needed
  return res;
};

export const getClient = async () => {
  const client = await pool.connect();
  return client;
};

export default pool;
