import { Client } from "pg";
import fs from "fs";
import path from "path";
import * as dotenv from "dotenv";

dotenv.config();

const runMigration = async () => {
  const host = process.env.DB_HOST || "localhost";
  const port = parseInt(process.env.DB_PORT || "5432");
  const user = process.env.DB_USER || "postgres";
  const password = process.env.DB_PASSWORD || "password";
  const databaseName = process.env.DB_NAME || "enterprise_hrms";

  console.log(`Connecting to default database 'postgres' on ${host}:${port} as user '${user}'...`);

  // Step 1: Connect to default postgres database to ensure the target DB exists
  const tempClient = new Client({
    host,
    port,
    user,
    password,
    database: "postgres",
  });

  try {
    await tempClient.connect();
    
    // Check if db exists
    const dbCheck = await tempClient.query(
      `SELECT 1 FROM pg_database WHERE datname = $1`,
      [databaseName]
    );

    if (dbCheck.rowCount === 0) {
      console.log(`Database '${databaseName}' does not exist. Creating...`);
      await tempClient.query(`CREATE DATABASE ${databaseName}`);
      console.log(`Database '${databaseName}' created successfully.`);
    } else {
      console.log(`Database '${databaseName}' already exists.`);
    }
  } catch (error) {
    console.error("Error checking/creating database:", error);
    process.exit(1);
  } finally {
    await tempClient.end();
  }

  // Step 2: Connect to target database and apply schema + seeds
  console.log(`Connecting to target database '${databaseName}'...`);
  const targetClient = new Client({
    host,
    port,
    user,
    password,
    database: databaseName,
  });

  try {
    await targetClient.connect();

    const schemaPath = path.join(__dirname, "../../database/schema.sql");
    const seedPath = path.join(__dirname, "../../database/seed.sql");

    console.log(`Reading schema from: ${schemaPath}`);
    const schemaSql = fs.readFileSync(schemaPath, "utf8");
    console.log("Applying schema...");
    // Clear public schema first to ensure clean state
    await targetClient.query("DROP SCHEMA public CASCADE; CREATE SCHEMA public;");
    await targetClient.query(schemaSql);
    console.log("Schema applied successfully.");

    console.log(`Reading seeds from: ${seedPath}`);
    const seedSql = fs.readFileSync(seedPath, "utf8");
    console.log("Applying seeds...");
    await targetClient.query(seedSql);
    console.log("Seeds applied successfully.");

  } catch (error) {
    console.error("Migration/seeding failed:", error);
    process.exit(1);
  } finally {
    await targetClient.end();
  }
};

runMigration();
