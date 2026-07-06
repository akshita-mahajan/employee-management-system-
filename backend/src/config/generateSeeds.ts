import fs from "fs";
import path from "path";

// Generates seed.sql programmatically with 65 realistic employees
const generateSeedFile = () => {
  const firstNames = [
    "John", "Jane", "Alice", "Bob", "Charlie", "David", "Emma", "Frank", "Grace", "Henry",
    "Ivy", "Jack", "Kate", "Leo", "Mia", "Nathan", "Olivia", "Paul", "Quinn", "Rachel",
    "Sam", "Tina", "Victor", "Wendy", "Xavier", "Yolanda", "Zach", "Arthur", "Beatrice", "Connor",
    "Diana", "Ethan", "Fiona", "George", "Hannah", "Ian", "Julia", "Kevin", "Laura", "Marcus",
    "Nora", "Oscar", "Penelope", "Quincy", "Rebecca", "Steven", "Teresa", "Ulysses", "Valerie", "Walter",
    "Xena", "Yosef", "Zoe", "Albert", "Brenda", "Carl", "Donna", "Edward", "Florence", "Gary",
    "Helen", "Logan", "Ruby", "Austin", "Clara"
  ];

  const lastNames = [
    "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez",
    "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin",
    "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson",
    "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores",
    "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts",
    "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes",
    "Stewart", "Morris", "Morales", "Murphy", "Cook"
  ];

  const roles = {
    ADMIN: "d1a3a31c-b631-41ee-a83d-6b5dfef6e801",
    HR: "d1a3a31c-b631-41ee-a83d-6b5dfef6e802",
    MANAGER: "d1a3a31c-b631-41ee-a83d-6b5dfef6e803",
    EMPLOYEE: "d1a3a31c-b631-41ee-a83d-6b5dfef6e804"
  };

  const departments = [
    { id: "c3a5a31c-b631-41ee-a83d-6b5dfef6f001", name: "Human Resources", code: "HR", budget: 150000.00 },
    { id: "c3a5a31c-b631-41ee-a83d-6b5dfef6f002", name: "Engineering", code: "ENG", budget: 750000.00 },
    { id: "c3a5a31c-b631-41ee-a83d-6b5dfef6f003", name: "Product Management", code: "PM", budget: 250000.00 },
    { id: "c3a5a31c-b631-41ee-a83d-6b5dfef6f004", name: "Finance & Accounts", code: "FIN", budget: 300000.00 },
    { id: "c3a5a31c-b631-41ee-a83d-6b5dfef6f005", name: "Sales & Marketing", code: "MKT", budget: 200000.00 }
  ];

  const leaveTypes = [
    { id: "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d", name: "Casual Leave", allowance: 12 },
    { id: "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e", name: "Sick Leave", allowance: 10 },
    { id: "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f", name: "Earned Leave", allowance: 18 }
  ];

  const generateUUID = (index: number, prefix: string) => {
    const hex = index.toString(16).padStart(12, "0");
    return `${prefix}-b631-41ee-a83d-${hex}`;
  };

  const output: string[] = [];

  output.push(`-- =============================================================
-- ENTERPRISE HRMS & WORKFORCE MANAGEMENT SYSTEM
-- Scaled Production-Grade Mock Seed Script (65 Authenticated Employees)
-- Generated automatically on demand
-- =============================================================

-- 1. SEED SYSTEM ROLES
INSERT INTO roles (id, name, description) VALUES
('${roles.ADMIN}', 'ADMIN', 'System Administrator with full permissions'),
('${roles.HR}', 'HR', 'HR Manager with access to workforce and leaves'),
('${roles.MANAGER}', 'MANAGER', 'Department / Team Leader managers'),
('${roles.EMPLOYEE}', 'EMPLOYEE', 'Standard Employee user access')
ON CONFLICT (id) DO NOTHING;

-- 2. SEED DEPARTMENTS (Manager ID set to NULL initially)
INSERT INTO departments (id, name, code, description, manager_id, budget) VALUES`);

  departments.forEach((dept, i) => {
    const comma = i === departments.length - 1 ? "" : ",";
    output.push(`('${dept.id}', '${dept.name}', '${dept.code}', 'Department handling ${dept.name.toLowerCase()} operations', null, ${dept.budget})${comma}`);
  });

  output.push(`ON CONFLICT (id) DO NOTHING;

-- 3. SEED LEAVE TYPES
INSERT INTO leave_types (id, name, allowance_days) VALUES`);

  leaveTypes.forEach((lt, i) => {
    const comma = i === leaveTypes.length - 1 ? "" : ",";
    output.push(`('${lt.id}', '${lt.name}', ${lt.allowance})${comma}`);
  });

  output.push(`ON CONFLICT (id) DO NOTHING;

-- 4. SEED USERS & EMPLOYEES & ASSIGN ROLES`);

  // Assign fixed accounts for keys
  const managers: string[] = []; // Store employee IDs of managers
  const hrAdmins: string[] = [];

  // Generate 65 authenticated employees
  for (let i = 1; i <= 65; i++) {
    const userId = generateUUID(i, "b2a4a31c");
    const empId = generateUUID(i, "e4a6a31c");
    const formattedEmpCode = `EMP-${i.toString().padStart(3, "0")}`;

    // Deterministic selection of names
    const firstName = firstNames[(i - 1) % firstNames.length];
    const lastName = lastNames[(i - 1) % lastNames.length];
    const email = i === 1 ? "admin@hrms.com" : `${firstName.toLowerCase()}.${lastName.toLowerCase()}@company.com`;
    const phone = `+1 555-${i.toString().padStart(4, "0")}`;

    // Determine Role and Department
    let assignedRoleId = roles.EMPLOYEE;
    let assignedRoleName = "EMPLOYEE";
    let dept = departments[i % departments.length]; // Cycle departments
    let designation = "Software Engineer";

    if (i === 1) {
      assignedRoleId = roles.ADMIN;
      assignedRoleName = "ADMIN";
      designation = "System Administrator";
      dept = departments[0]; // HR
    } else if (i === 2 || i === 3) {
      assignedRoleId = roles.HR;
      assignedRoleName = "HR";
      designation = i === 2 ? "HR Director" : "Talent Acquisition Lead";
      dept = departments[0]; // HR
      hrAdmins.push(empId);
    } else if (i >= 4 && i <= 8) {
      // Setup 5 Managers
      assignedRoleId = roles.MANAGER;
      assignedRoleName = "MANAGER";
      designation = `Lead ${dept.name} Manager`;
      managers.push(empId);
    } else {
      // General employees
      if (dept.code === "ENG") {
        designation = i % 3 === 0 ? "Senior Software Engineer" : "Associate Developer";
      } else if (dept.code === "PM") {
        designation = "Product Specialist";
      } else if (dept.code === "FIN") {
        designation = "Financial Analyst";
      } else if (dept.code === "MKT") {
        designation = "Marketing Representative";
      } else {
        designation = "HR Associate";
      }
    }

    // Insert User
    output.push(`
INSERT INTO users (id, email, password_hash, is_active) VALUES
('${userId}', '${email}', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;`);

    // Assign Role
    output.push(`
INSERT INTO user_roles (user_id, role_id) VALUES
('${userId}', '${assignedRoleId}') ON CONFLICT (user_id, role_id) DO NOTHING;`);

    // Reporting Manager selection
    const reportingManagerId = i <= 8 ? "null" : `'${managers[(i % managers.length)]}'`;

    // Insert Employee
    output.push(`
INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('${empId}', '${userId}', '${formattedEmpCode}', '${firstName}', '${lastName}', '${email}', '${phone}', '${dept.id}', '${designation}', '2023-06-01', 'ACTIVE', ${reportingManagerId}) ON CONFLICT (id) DO NOTHING;`);

    // Salary Structure
    const baseSalary = 4000 + (i * 120);
    const hra = baseSalary * 0.4;
    const lta = baseSalary * 0.15;
    const salaryId = generateUUID(i, "b9a2a31c");
    output.push(`
INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('${salaryId}', '${empId}', ${baseSalary.toFixed(2)}, ${hra.toFixed(2)}, ${lta.toFixed(2)}) ON CONFLICT (id) DO NOTHING;`);

    // Leave Balances
    leaveTypes.forEach((lt, j) => {
      const balanceId = generateUUID(i * 10 + j, "a7b3c4d5");
      output.push(`
INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('${balanceId}', '${empId}', '${lt.id}', ${lt.allowance}.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;`);
    });
  }

  // Link Managers to Departments
  output.push(`
-- Link managers to departments
UPDATE departments SET manager_id = '${generateUUID(2, "e4a6a31c")}' WHERE id = '${departments[0].id}';
UPDATE departments SET manager_id = '${generateUUID(4, "e4a6a31c")}' WHERE id = '${departments[1].id}';
UPDATE departments SET manager_id = '${generateUUID(5, "e4a6a31c")}' WHERE id = '${departments[2].id}';
UPDATE departments SET manager_id = '${generateUUID(6, "e4a6a31c")}' WHERE id = '${departments[3].id}';
UPDATE departments SET manager_id = '${generateUUID(7, "e4a6a31c")}' WHERE id = '${departments[4].id}';
`);

  const destPath = path.join(__dirname, "../../database/seed.sql");
  fs.writeFileSync(destPath, output.join("\n"));
  console.log(`Successfully generated seed SQL with 65 employees at: ${destPath}`);
};

generateSeedFile();
