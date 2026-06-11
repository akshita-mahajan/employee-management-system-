import pool from "./database.js";

const verifyDatabase = async () => {
  console.log("Checking database tables and records...");
  try {
    // 1. Roles
    const rolesRes = await pool.query("SELECT COUNT(*)::int as count FROM roles");
    console.log(`- Roles table count: ${rolesRes.rows[0].count}`);

    // 2. Users
    const usersRes = await pool.query("SELECT email, is_active FROM users");
    console.log(`- Users sample list:`);
    usersRes.rows.forEach(u => console.log(`  * ${u.email} (Active: ${u.is_active})`));

    // 3. Employees
    const empRes = await pool.query("SELECT first_name, last_name, employee_id, designation FROM employees");
    console.log(`- Employees sample list:`);
    empRes.rows.forEach(e => console.log(`  * [${e.employee_id}] ${e.first_name} ${e.last_name} - ${e.designation}`));

    // 4. Departments
    const deptRes = await pool.query("SELECT name, code, budget FROM departments");
    console.log(`- Departments sample list:`);
    deptRes.rows.forEach(d => console.log(`  * ${d.name} (${d.code}) - Budget: $${d.budget}`));

    // 5. Assets
    const assetRes = await pool.query("SELECT name, code, status, value FROM assets");
    console.log(`- Assets sample list:`);
    assetRes.rows.forEach(a => console.log(`  * ${a.name} (${a.code}) - Status: ${a.status}, Value: $${a.value}`));

  } catch (error) {
    console.error("Verification query failed:", error);
  } finally {
    await pool.end();
  }
};

verifyDatabase();
