import fs from "fs";
import path from "path";

// Generates seed.sql programmatically with 65 realistic employees and historical payroll logs
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

  // Store metadata
  const employeesList: { id: string; base: number; hra: number; lta: number }[] = [];
  const managers: string[] = []; // Store employee IDs of managers

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
    let dept = departments[i % departments.length]; // Cycle departments
    let designation = "Software Engineer";

    if (i === 1) {
      assignedRoleId = roles.ADMIN;
      designation = "System Administrator";
      dept = departments[0]; // HR
    } else if (i === 2 || i === 3) {
      assignedRoleId = roles.HR;
      designation = i === 2 ? "HR Director" : "Talent Acquisition Lead";
      dept = departments[0]; // HR
    } else if (i >= 4 && i <= 8) {
      assignedRoleId = roles.MANAGER;
      designation = `Lead ${dept.name} Manager`;
      managers.push(empId);
    } else {
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

    // Salary Structure calculations
    const baseSalary = 40000 + (i * 1200); // realistic Indian Rupee structure or consistent scales
    const hra = baseSalary * 0.4;
    const lta = baseSalary * 0.15;
    const salaryId = generateUUID(i, "b9a2a31c");
    output.push(`
INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('${salaryId}', '${empId}', ${baseSalary.toFixed(2)}, ${hra.toFixed(2)}, ${lta.toFixed(2)}) ON CONFLICT (id) DO NOTHING;`);

    employeesList.push({ id: empId, base: baseSalary, hra, lta });

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

  // Seeding Payroll Runs & Payslips (May 2026, June 2026, and Pending Draft July 2026)
  const months = [
    { name: "May 2026", dateStr: "2026-05-30 18:00:00+00", runId: "d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01", status: "PROCESSED" },
    { name: "June 2026", dateStr: "2026-06-30 18:00:00+00", runId: "d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02", status: "PROCESSED" },
    { name: "July 2026 (Draft)", dateStr: "2026-07-06 12:00:00+00", runId: "d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f03", status: "PENDING" }
  ];

  output.push(`-- 5. SEED PAYROLL RUNS AND HISTORICAL PAYSLIPS`);

  months.forEach((m) => {
    // Process net payouts for PROCESSED runs
    let totalPayout = 0;
    if (m.status === "PROCESSED") {
      employeesList.forEach((emp) => {
        const gross = emp.base + emp.hra + emp.lta;
        const pf = emp.base * 0.12;
        const pt = 200.00;
        const net = gross - (pf + pt);
        totalPayout += net;
      });
    }

    output.push(`
INSERT INTO payroll_runs (id, billing_month, status, total_payout, created_at, updated_at) VALUES
('${m.runId}', '${m.name}', '${m.status}', ${totalPayout.toFixed(2)}, '${m.dateStr}', '${m.dateStr}') ON CONFLICT (id) DO NOTHING;`);

    // If PROCESSED, seed payslips and components for all 65 employees
    if (m.status === "PROCESSED") {
      employeesList.forEach((emp, index) => {
        const payslipId = generateUUID(index + (m.name === "May 2026" ? 100 : 200), "d1a3a31c");
        const gross = emp.base + emp.hra + emp.lta;
        const pf = emp.base * 0.12;
        const pt = 200.00;
        const net = gross - (pf + pt);

        output.push(`
INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('${payslipId}', '${m.runId}', '${emp.id}', ${net.toFixed(2)}, '${m.dateStr}') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('${payslipId}', 'Basic Salary', 'EARNING', ${emp.base.toFixed(2)}),
('${payslipId}', 'House Rent Allowance (HRA)', 'EARNING', ${emp.hra.toFixed(2)}),
('${payslipId}', 'Leave Travel Allowance (LTA)', 'EARNING', ${emp.lta.toFixed(2)}),
('${payslipId}', 'Provident Fund (PF)', 'DEDUCTION', ${pf.toFixed(2)}),
('${payslipId}', 'Professional Tax', 'DEDUCTION', ${pt.toFixed(2)})
ON CONFLICT (id) DO NOTHING;`);
      });
    }
  });

  const destPath = path.join(__dirname, "../../database/seed.sql");
  fs.writeFileSync(destPath, output.join("\n"));
  console.log(`Successfully generated seed SQL with 65 employees and payroll at: ${destPath}`);
};

generateSeedFile();
