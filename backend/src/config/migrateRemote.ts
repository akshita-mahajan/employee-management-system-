import { Client } from "pg";
import fs from "fs";
import path from "path";

const runRemoteMigration = async () => {
  const connectionString = "postgresql://neondb_owner:npg_8u9EAPBnyKNF@ep-snowy-bird-aomrao62.c-2.ap-southeast-1.aws.neon.tech/neondb?sslmode=require";

  console.log("Connecting to remote Neon PostgreSQL database...");
  const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    console.log("Connected successfully to Neon database.");

    // Relative to dist/config/migrateRemote.js (goes up to backend/ folder)
    const schemaPath = path.join(__dirname, "../../database/schema.sql");
    const seedPath = path.join(__dirname, "../../database/seed.sql");

    console.log("Applying schema...");
    const schemaSql = fs.readFileSync(schemaPath, "utf8");
    await client.query("DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;");
    await client.query(schemaSql);
    console.log("Schema applied successfully.");

    console.log("Applying seed data...");
    const seedSql = fs.readFileSync(seedPath, "utf8");
    await client.query(seedSql);
    console.log("Seed data applied successfully.");

    console.log("Seeding additional RBAC roles...");
    await client.query(`
      INSERT INTO roles (name, description) VALUES
      ('SUPER_ADMIN', 'Super Admin with full access'),
      ('HR_ADMIN', 'HR Admin with workforce management'),
      ('PAYROLL_ADMIN', 'Payroll administrator'),
      ('TEAM_LEAD', 'Team leader'),
      ('INTERN', 'Intern staff'),
      ('AUDITOR', 'Read only auditor')
      ON CONFLICT (name) DO NOTHING;
    `);
    console.log("RBAC roles seeded successfully.");

  } catch (error) {
    console.error("Remote migration/seeding failed:", error);
    process.exit(1);
  } finally {
    await client.end();
    console.log("Connection closed.");
  }
};

runRemoteMigration();
