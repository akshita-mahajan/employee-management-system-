-- =============================================================
-- ENTERPRISE HRMS & WORKFORCE MANAGEMENT SYSTEM
-- PostgreSQL Database Seed Scripts
-- Initializing System Configs, Administrative User Accounts & Core Mock Tables
-- =============================================================

-- 1. SEED SYSTEM ROLES
INSERT INTO roles (id, name, description) VALUES
('d1a3a31c-b631-41ee-a83d-6b5dfef6e801', 'ADMIN', 'System Administrator with full permissions'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e802', 'HR', 'HR Manager with access to workforce and leaves'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e803', 'MANAGER', 'Department / Team Leader managers'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e804', 'EMPLOYEE', 'Standard Employee user access')
ON CONFLICT (id) DO NOTHING;

-- 2. SEED USERS (Passwords hashed using standard keys: password123 or farmhouse@123)
INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'admin@hrms.com', '$2b$10$dummyhashadminpassword123', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'jane.miller@company.com', '$2b$10$dummyhashjanemillerpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'alice.vance@company.com', '$2b$10$dummyhashalicevancepassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e904', 'hr.lead@company.com', '$2b$10$dummyhashhrleadpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e905', 'eng.manager@company.com', '$2b$10$dummyhashengmanagerpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e906', 'finance.lead@company.com', '$2b$10$dummyhashfinanceleadpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e907', 'senior.dev@company.com', '$2b$10$dummyhashseniordevpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e908', 'intern@company.com', '$2b$10$dummyhashinternpassword', true)
ON CONFLICT (id) DO NOTHING;

-- 3. ASSIGN USER ROLES
INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e801'), -- Admin -> ADMIN
('b2a4a31c-b631-41ee-a83d-6b5dfef6e904', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e802'), -- hr.lead -> HR
('b2a4a31c-b631-41ee-a83d-6b5dfef6e905', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803'), -- eng.manager -> MANAGER
('b2a4a31c-b631-41ee-a83d-6b5dfef6e906', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803'), -- finance.lead -> MANAGER
('b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804'), -- Jane Miller -> EMPLOYEE
('b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804'), -- Alice Vance -> EMPLOYEE
('b2a4a31c-b631-41ee-a83d-6b5dfef6e907', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804'), -- senior.dev -> EMPLOYEE
('b2a4a31c-b631-41ee-a83d-6b5dfef6e908', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804')  -- intern -> EMPLOYEE
ON CONFLICT (user_id, role_id) DO NOTHING;

-- 4. SEED DEPARTMENTS (Manager field set to NULL initially to prevent constraints failure)
INSERT INTO departments (id, name, code, description, manager_id, budget) VALUES
('c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Human Resources', 'HR', 'Manages employee lifecycles and payroll configurations', null, 150000.00),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Engineering', 'ENG', 'Handles software product development systems', null, 750000.00),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Management', 'PM', 'Coordinates design pipelines and timelines', null, 250000.00),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Finance & Accounts', 'FIN', 'Manages audits, budgets and business accounts', null, 300000.00)
ON CONFLICT (id) DO NOTHING;

-- 5. SEED EMPLOYEES
INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-6b5dfef6f101', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'EMP-001', 'John', 'Admin', 'admin@hrms.com', '+1 555-0100', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'System Administrator', '2023-01-15', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f104', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e904', 'EMP-004', 'Sarah', 'Connor', 'hr.lead@company.com', '+1 555-0104', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Director', '2023-05-10', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f105', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e905', 'EMP-005', 'David', 'Hassel', 'eng.manager@company.com', '+1 555-0105', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'VP of Engineering', '2023-02-12', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f106', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e906', 'EMP-006', 'Robert', 'Kiyosaki', 'finance.lead@company.com', '+1 555-0106', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Chief Finance Officer', '2023-09-01', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'EMP-002', 'Jane', 'Miller', 'jane.miller@company.com', '+1 555-0122', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Senior Software Engineer', '2024-03-20', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105'),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f103', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'EMP-003', 'Alice', 'Vance', 'alice.vance@company.com', '+1 555-0155', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Director', '2023-08-10', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f107', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e907', 'EMP-007', 'Alex', 'Mercer', 'senior.dev@company.com', '+1 555-0107', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Technical Lead', '2023-11-15', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105'),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f108', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e908', 'EMP-008', 'Tim', 'Cook', 'intern@company.com', '+1 555-0108', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Engineering Intern', '2025-01-05', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105')
ON CONFLICT (id) DO NOTHING;

-- 6. SET DEPARTMENTS MANAGER FOREIGN REFERENCE KEY LINKS
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f104' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f103' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f106' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004';

-- 7. SEED TEAMS
INSERT INTO teams (id, name, code, department_id, team_lead_id) VALUES
('f5a7a31c-b631-41ee-a83d-6b5dfef6f201', 'Frontend Engineering', 'ENG-FE', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107'),
('f5a7a31c-b631-41ee-a83d-6b5dfef6f202', 'Core Infrastructure', 'ENG-INFRA', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105')
ON CONFLICT (id) DO NOTHING;

-- 8. SEED TEAM MEMBERS
INSERT INTO team_members (team_id, employee_id) VALUES
('f5a7a31c-b631-41ee-a83d-6b5dfef6f201', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102'),
('f5a7a31c-b631-41ee-a83d-6b5dfef6f201', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f108'),
('f5a7a31c-b631-41ee-a83d-6b5dfef6f202', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107')
ON CONFLICT (team_id, employee_id) DO NOTHING;

-- 9. SEED LEAVE TYPES
INSERT INTO leave_types (id, name, allowance_days) VALUES
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Casual Leave', 12),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 'Sick Leave', 10),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 'Earned Leave', 18)
ON CONFLICT (id) DO NOTHING;

-- 10. SEED LEAVE BALANCES
INSERT INTO leave_balances (employee_id, leave_type_id, allocated, used) VALUES
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 4.0),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 3.0),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f107', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 2.0),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f107', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 5.0)
ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

-- 11. SEED ASSET CATEGORIES
INSERT INTO asset_categories (id, name, description) VALUES
('c6a8a31c-b631-41ee-a83d-6b5dfef6f301', 'Laptop', 'Corporate computing devices'),
('c6a8a31c-b631-41ee-a83d-6b5dfef6f302', 'Monitor', 'Visual display monitors'),
('c6a8a31c-b631-41ee-a83d-6b5dfef6f303', 'Software License', 'System design application seats')
ON CONFLICT (id) DO NOTHING;

-- 12. SEED ASSETS
INSERT INTO assets (id, category_id, name, code, status, value) VALUES
('d7a9a31c-b631-41ee-a83d-6b5dfef6f401', 'c6a8a31c-b631-41ee-a83d-6b5dfef6f301', 'MacBook Pro M3 Max', 'SN-MBP-001', 'Assigned', 3499.00),
('d7a9a31c-b631-41ee-a83d-6b5dfef6f402', 'c6a8a31c-b631-41ee-a83d-6b5dfef6f302', 'Dell UltraSharp 32 4K', 'SN-DEL-982', 'Available', 699.00),
('d7a9a31c-b631-41ee-a83d-6b5dfef6f403', 'c6a8a31c-b631-41ee-a83d-6b5dfef6f301', 'ThinkPad P1 Gen 6', 'SN-THINK-102', 'Assigned', 2899.00)
ON CONFLICT (id) DO NOTHING;

-- 13. SEED ASSET ASSIGNMENTS
INSERT INTO asset_assignments (id, asset_id, employee_id, assigned_date, returned_date, notes) VALUES
('e8b0a31c-b631-41ee-a83d-6b5dfef6f501', 'd7a9a31c-b631-41ee-a83d-6b5dfef6f401', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102', '2024-03-22 09:00:00+00', null, 'Standard development machine for Senior Engineer'),
('e8b0a31c-b631-41ee-a83d-6b5dfef6f502', 'd7a9a31c-b631-41ee-a83d-6b5dfef6f403', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107', '2023-11-20 10:00:00+00', null, 'Assigned to Technical Lead')
ON CONFLICT (id) DO NOTHING;

-- 14. SEED SALARY STRUCTURES
INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-6b5dfef6f601', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 8500.00, 3400.00, 1200.00), -- Jane Miller
('b9a2a31c-b631-41ee-a83d-6b5dfef6f602', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107', 11000.00, 4400.00, 1500.00), -- Alex Mercer
('b9a2a31c-b631-41ee-a83d-6b5dfef6f603', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f108', 3500.00, 1400.00, 500.00) -- Tim Cook
ON CONFLICT (id) DO NOTHING;

-- 15. SEED ATTENDANCE & LOGS
INSERT INTO attendance (id, employee_id, date, status) VALUES
('a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c01', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102', '2026-07-01', 'PRESENT'),
('a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c02', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102', '2026-07-02', 'PRESENT'),
('a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c03', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107', '2026-07-01', 'PRESENT'),
('a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c04', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107', '2026-07-02', 'PRESENT')
ON CONFLICT (id) DO NOTHING;

INSERT INTO attendance_logs (id, attendance_id, check_in, check_out, overtime_mins, is_late) VALUES
('c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e01', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c01', '2026-07-01 08:50:00+00', '2026-07-01 18:10:00+00', 60, false),
('c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e02', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c02', '2026-07-02 09:12:00+00', '2026-07-02 18:00:00+00', 0, true),
('c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e03', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c03', '2026-07-01 08:45:00+00', '2026-07-01 17:45:00+00', 0, false),
('c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e04', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c04', '2026-07-02 08:55:00+00', '2026-07-02 18:30:00+00', 80, false)
ON CONFLICT (id) DO NOTHING;

-- 16. SEED LEAVE REQUESTS
INSERT INTO leave_requests (id, employee_id, leave_type_id, start_date, end_date, reason, status, approved_by) VALUES
('b3a5a31c-b631-41ee-a83d-6b5dfef6e991', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', '2026-07-10', '2026-07-12', 'Family function gathering', 'PENDING', null),
('b3a5a31c-b631-41ee-a83d-6b5dfef6e992', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f107', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', '2026-06-15', '2026-06-16', 'Medical checkup', 'APPROVED', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f105')
ON CONFLICT (id) DO NOTHING;
