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
('d1a3a31c-b631-41ee-a83d-6b5dfef6e804', 'EMPLOYEE', 'Standard Employee user access');

-- 2. SEED USERS (Passwords hashed using dummy keys for mock setups)
INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'admin@hrms.com', '$2b$10$dummyhashadminpassword123', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'jane.miller@company.com', '$2b$10$dummyhashjanemillerpassword', true),
('b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'alice.vance@company.com', '$2b$10$dummyhashalicevancepassword', true);

-- 3. ASSIGN USER ROLES
INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e801'), -- Admin
('b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804'), -- Jane (Employee)
('b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803'); -- Alice (Manager)

-- 4. SEED DEPARTMENTS (Manager field set to NULL initially to prevent constraints failure)
INSERT INTO departments (id, name, code, description, manager_id, budget) VALUES
('c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Human Resources', 'HR', 'Manages employee lifecycles and payroll configurations', null, 95000.00),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Engineering', 'ENG', 'Handles software product development systems', null, 450000.00),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Management', 'PM', 'Coordinates design pipelines and timelines', null, 220000.00);

-- 5. SEED EMPLOYEES
INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-6b5dfef6f101', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e901', 'EMP-001', 'John', 'Admin', 'admin@hrms.com', '+1 555-0100', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Lead HR Specialist', '2024-01-15', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e902', 'EMP-002', 'Jane', 'Miller', 'jane.miller@company.com', '+1 555-0122', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Senior Software Engineer', '2024-03-20', 'ACTIVE', null),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f103', 'b2a4a31c-b631-41ee-a83d-6b5dfef6e903', 'EMP-003', 'Alice', 'Vance', 'alice.vance@company.com', '+1 555-0155', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Director', '2023-08-10', 'ON_LEAVE', null);

-- 6. SET DEPARTMENTS MANAGER FOREIGN REFERENCE KEY LINKS
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f101' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f103' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003';

-- Set Jane's Reporting Manager to Alice Vance
UPDATE employees SET reporting_manager_id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f103' WHERE id = 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102';

-- 7. SEED TEAMS
INSERT INTO teams (id, name, code, department_id, team_lead_id) VALUES
('f5a7a31c-b631-41ee-a83d-6b5dfef6f201', 'Frontend Engineering', 'ENG-FE', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f103');

-- 8. SEED TEAM MEMBERS
INSERT INTO team_members (team_id, employee_id) VALUES
('f5a7a31c-b631-41ee-a83d-6b5dfef6f201', 'e4a6a31c-b631-41ee-a83d-6b5dfef6f102');

-- 9. SEED LEAVE TYPES
INSERT INTO leave_types (id, name, allowance_days) VALUES
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Casual Leave', 12),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 'Sick Leave', 10),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 'Earned Leave', 18);

-- 10. SEED LEAVE BALANCES
INSERT INTO leave_balances (employee_id, leave_type_id, allocated, used) VALUES
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 4.0),
('e4a6a31c-b631-41ee-a83d-6b5dfef6f102', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 3.0);

-- 11. SEED ASSET CATEGORIES
INSERT INTO asset_categories (id, name, description) VALUES
('g6a8a31c-b631-41ee-a83d-6b5dfef6f301', 'Laptop', 'Corporate computing devices'),
('g6a8a31c-b631-41ee-a83d-6b5dfef6f302', 'Monitor', 'Visual display monitors'),
('g6a8a31c-b631-41ee-a83d-6b5dfef6f303', 'Software License', 'System design application seats');

-- 12. SEED ASSETS
INSERT INTO assets (id, category_id, name, code, status, value) VALUES
('h7a9a31c-b631-41ee-a83d-6b5dfef6f401', 'g6a8a31c-b631-41ee-a83d-6b5dfef6f301', 'MacBook Pro M3', 'SN-MBP-001', 'Assigned', 2499.00),
('h7a9a31c-b631-41ee-a83d-6b5dfef6f402', 'g6a8a31c-b631-41ee-a83d-6b5dfef6f302', 'Dell UltraSharp 27', 'SN-DEL-982', 'Available', 450.00);
