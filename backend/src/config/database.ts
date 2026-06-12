import { Pool } from "pg";
import * as dotenv from "dotenv";
import path from "path";

// Load environment variables from backend/.env file
const envPath = path.join(__dirname, "../../.env");
dotenv.config({ path: envPath });
console.log(`[DB Pool Setup] Parameters: Host=${process.env.DB_HOST}, Port=${process.env.DB_PORT}, DB=${process.env.DB_NAME}, User=${process.env.DB_USER}, PwdLength=${process.env.DB_PASSWORD ? process.env.DB_PASSWORD.length : 0}`);

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
