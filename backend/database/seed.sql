-- =============================================================
-- ENTERPRISE HRMS & WORKFORCE MANAGEMENT SYSTEM
-- Scaled Production-Grade Mock Seed Script (65 Authenticated Employees)
-- Generated automatically on demand
-- =============================================================

-- 1. SEED SYSTEM ROLES
INSERT INTO roles (id, name, description) VALUES
('d1a3a31c-b631-41ee-a83d-6b5dfef6e801', 'ADMIN', 'System Administrator with full permissions'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e802', 'HR', 'HR Manager with access to workforce and leaves'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e803', 'MANAGER', 'Department / Team Leader managers'),
('d1a3a31c-b631-41ee-a83d-6b5dfef6e804', 'EMPLOYEE', 'Standard Employee user access')
ON CONFLICT (id) DO NOTHING;

-- 2. SEED DEPARTMENTS (Manager ID set to NULL initially)
INSERT INTO departments (id, name, code, description, manager_id, budget) VALUES
('c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Human Resources', 'HR', 'Department handling human resources operations', null, 150000),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Engineering', 'ENG', 'Department handling engineering operations', null, 750000),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Management', 'PM', 'Department handling product management operations', null, 250000),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Finance & Accounts', 'FIN', 'Department handling finance & accounts operations', null, 300000),
('c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Sales & Marketing', 'MKT', 'Department handling sales & marketing operations', null, 200000)
ON CONFLICT (id) DO NOTHING;

-- 3. SEED LEAVE TYPES
INSERT INTO leave_types (id, name, allowance_days) VALUES
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Casual Leave', 12),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 'Sick Leave', 10),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 'Earned Leave', 18)
ON CONFLICT (id) DO NOTHING;

-- 4. SEED USERS & EMPLOYEES & ASSIGN ROLES

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000001', 'admin@hrms.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000001', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e801') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000001', 'b2a4a31c-b631-41ee-a83d-000000000001', 'EMP-001', 'John', 'Smith', 'admin@hrms.com', '+1 555-0001', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'System Administrator', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000001', 'e4a6a31c-b631-41ee-a83d-000000000001', 4120.00, 1648.00, 618.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000000a', 'e4a6a31c-b631-41ee-a83d-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000000b', 'e4a6a31c-b631-41ee-a83d-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000000c', 'e4a6a31c-b631-41ee-a83d-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000002', 'jane.johnson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000002', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e802') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000002', 'b2a4a31c-b631-41ee-a83d-000000000002', 'EMP-002', 'Jane', 'Johnson', 'jane.johnson@company.com', '+1 555-0002', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Director', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000002', 'e4a6a31c-b631-41ee-a83d-000000000002', 4240.00, 1696.00, 636.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000014', 'e4a6a31c-b631-41ee-a83d-000000000002', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000015', 'e4a6a31c-b631-41ee-a83d-000000000002', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000016', 'e4a6a31c-b631-41ee-a83d-000000000002', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000003', 'alice.williams@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000003', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e802') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000003', 'b2a4a31c-b631-41ee-a83d-000000000003', 'EMP-003', 'Alice', 'Williams', 'alice.williams@company.com', '+1 555-0003', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Talent Acquisition Lead', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000003', 'e4a6a31c-b631-41ee-a83d-000000000003', 4360.00, 1744.00, 654.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000001e', 'e4a6a31c-b631-41ee-a83d-000000000003', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000001f', 'e4a6a31c-b631-41ee-a83d-000000000003', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000020', 'e4a6a31c-b631-41ee-a83d-000000000003', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000004', 'bob.brown@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000004', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000004', 'b2a4a31c-b631-41ee-a83d-000000000004', 'EMP-004', 'Bob', 'Brown', 'bob.brown@company.com', '+1 555-0004', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Lead Sales & Marketing Manager', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000004', 'e4a6a31c-b631-41ee-a83d-000000000004', 4480.00, 1792.00, 672.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000028', 'e4a6a31c-b631-41ee-a83d-000000000004', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000029', 'e4a6a31c-b631-41ee-a83d-000000000004', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000002a', 'e4a6a31c-b631-41ee-a83d-000000000004', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000005', 'charlie.jones@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000005', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000005', 'b2a4a31c-b631-41ee-a83d-000000000005', 'EMP-005', 'Charlie', 'Jones', 'charlie.jones@company.com', '+1 555-0005', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'Lead Human Resources Manager', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000005', 'e4a6a31c-b631-41ee-a83d-000000000005', 4600.00, 1840.00, 690.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000032', 'e4a6a31c-b631-41ee-a83d-000000000005', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000033', 'e4a6a31c-b631-41ee-a83d-000000000005', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000034', 'e4a6a31c-b631-41ee-a83d-000000000005', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000006', 'david.garcia@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000006', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000006', 'b2a4a31c-b631-41ee-a83d-000000000006', 'EMP-006', 'David', 'Garcia', 'david.garcia@company.com', '+1 555-0006', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Lead Engineering Manager', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000006', 'e4a6a31c-b631-41ee-a83d-000000000006', 4720.00, 1888.00, 708.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000003c', 'e4a6a31c-b631-41ee-a83d-000000000006', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000003d', 'e4a6a31c-b631-41ee-a83d-000000000006', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000003e', 'e4a6a31c-b631-41ee-a83d-000000000006', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000007', 'emma.miller@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000007', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000007', 'b2a4a31c-b631-41ee-a83d-000000000007', 'EMP-007', 'Emma', 'Miller', 'emma.miller@company.com', '+1 555-0007', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Lead Product Management Manager', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000007', 'e4a6a31c-b631-41ee-a83d-000000000007', 4840.00, 1936.00, 726.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000046', 'e4a6a31c-b631-41ee-a83d-000000000007', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000047', 'e4a6a31c-b631-41ee-a83d-000000000007', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000048', 'e4a6a31c-b631-41ee-a83d-000000000007', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000008', 'frank.davis@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000008', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e803') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000008', 'b2a4a31c-b631-41ee-a83d-000000000008', 'EMP-008', 'Frank', 'Davis', 'frank.davis@company.com', '+1 555-0008', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Lead Finance & Accounts Manager', '2023-06-01', 'ACTIVE', null) ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000008', 'e4a6a31c-b631-41ee-a83d-000000000008', 4960.00, 1984.00, 744.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000050', 'e4a6a31c-b631-41ee-a83d-000000000008', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000051', 'e4a6a31c-b631-41ee-a83d-000000000008', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000052', 'e4a6a31c-b631-41ee-a83d-000000000008', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000009', 'grace.rodriguez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000009', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000009', 'b2a4a31c-b631-41ee-a83d-000000000009', 'EMP-009', 'Grace', 'Rodriguez', 'grace.rodriguez@company.com', '+1 555-0009', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000009', 'e4a6a31c-b631-41ee-a83d-000000000009', 5080.00, 2032.00, 762.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000005a', 'e4a6a31c-b631-41ee-a83d-000000000009', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000005b', 'e4a6a31c-b631-41ee-a83d-000000000009', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000005c', 'e4a6a31c-b631-41ee-a83d-000000000009', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000a', 'henry.martinez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000a', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000a', 'b2a4a31c-b631-41ee-a83d-00000000000a', 'EMP-010', 'Henry', 'Martinez', 'henry.martinez@company.com', '+1 555-0010', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000a', 'e4a6a31c-b631-41ee-a83d-00000000000a', 5200.00, 2080.00, 780.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000064', 'e4a6a31c-b631-41ee-a83d-00000000000a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000065', 'e4a6a31c-b631-41ee-a83d-00000000000a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000066', 'e4a6a31c-b631-41ee-a83d-00000000000a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000b', 'ivy.hernandez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000b', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000b', 'b2a4a31c-b631-41ee-a83d-00000000000b', 'EMP-011', 'Ivy', 'Hernandez', 'ivy.hernandez@company.com', '+1 555-0011', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000b', 'e4a6a31c-b631-41ee-a83d-00000000000b', 5320.00, 2128.00, 798.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000006e', 'e4a6a31c-b631-41ee-a83d-00000000000b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000006f', 'e4a6a31c-b631-41ee-a83d-00000000000b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000070', 'e4a6a31c-b631-41ee-a83d-00000000000b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000c', 'jack.lopez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000c', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000c', 'b2a4a31c-b631-41ee-a83d-00000000000c', 'EMP-012', 'Jack', 'Lopez', 'jack.lopez@company.com', '+1 555-0012', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000c', 'e4a6a31c-b631-41ee-a83d-00000000000c', 5440.00, 2176.00, 816.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000078', 'e4a6a31c-b631-41ee-a83d-00000000000c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000079', 'e4a6a31c-b631-41ee-a83d-00000000000c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000007a', 'e4a6a31c-b631-41ee-a83d-00000000000c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000d', 'kate.gonzalez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000d', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000d', 'b2a4a31c-b631-41ee-a83d-00000000000d', 'EMP-013', 'Kate', 'Gonzalez', 'kate.gonzalez@company.com', '+1 555-0013', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000d', 'e4a6a31c-b631-41ee-a83d-00000000000d', 5560.00, 2224.00, 834.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000082', 'e4a6a31c-b631-41ee-a83d-00000000000d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000083', 'e4a6a31c-b631-41ee-a83d-00000000000d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000084', 'e4a6a31c-b631-41ee-a83d-00000000000d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000e', 'leo.wilson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000e', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000e', 'b2a4a31c-b631-41ee-a83d-00000000000e', 'EMP-014', 'Leo', 'Wilson', 'leo.wilson@company.com', '+1 555-0014', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000e', 'e4a6a31c-b631-41ee-a83d-00000000000e', 5680.00, 2272.00, 852.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000008c', 'e4a6a31c-b631-41ee-a83d-00000000000e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000008d', 'e4a6a31c-b631-41ee-a83d-00000000000e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000008e', 'e4a6a31c-b631-41ee-a83d-00000000000e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000f', 'mia.anderson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000000f', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000000f', 'b2a4a31c-b631-41ee-a83d-00000000000f', 'EMP-015', 'Mia', 'Anderson', 'mia.anderson@company.com', '+1 555-0015', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000000f', 'e4a6a31c-b631-41ee-a83d-00000000000f', 5800.00, 2320.00, 870.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000096', 'e4a6a31c-b631-41ee-a83d-00000000000f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000097', 'e4a6a31c-b631-41ee-a83d-00000000000f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000098', 'e4a6a31c-b631-41ee-a83d-00000000000f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000010', 'nathan.thomas@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000010', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000010', 'b2a4a31c-b631-41ee-a83d-000000000010', 'EMP-016', 'Nathan', 'Thomas', 'nathan.thomas@company.com', '+1 555-0016', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000010', 'e4a6a31c-b631-41ee-a83d-000000000010', 5920.00, 2368.00, 888.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000a0', 'e4a6a31c-b631-41ee-a83d-000000000010', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000a1', 'e4a6a31c-b631-41ee-a83d-000000000010', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000a2', 'e4a6a31c-b631-41ee-a83d-000000000010', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000011', 'olivia.taylor@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000011', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000011', 'b2a4a31c-b631-41ee-a83d-000000000011', 'EMP-017', 'Olivia', 'Taylor', 'olivia.taylor@company.com', '+1 555-0017', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000011', 'e4a6a31c-b631-41ee-a83d-000000000011', 6040.00, 2416.00, 906.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000aa', 'e4a6a31c-b631-41ee-a83d-000000000011', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000ab', 'e4a6a31c-b631-41ee-a83d-000000000011', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000ac', 'e4a6a31c-b631-41ee-a83d-000000000011', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000012', 'paul.moore@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000012', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000012', 'b2a4a31c-b631-41ee-a83d-000000000012', 'EMP-018', 'Paul', 'Moore', 'paul.moore@company.com', '+1 555-0018', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000012', 'e4a6a31c-b631-41ee-a83d-000000000012', 6160.00, 2464.00, 924.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000b4', 'e4a6a31c-b631-41ee-a83d-000000000012', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000b5', 'e4a6a31c-b631-41ee-a83d-000000000012', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000b6', 'e4a6a31c-b631-41ee-a83d-000000000012', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000013', 'quinn.jackson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000013', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000013', 'b2a4a31c-b631-41ee-a83d-000000000013', 'EMP-019', 'Quinn', 'Jackson', 'quinn.jackson@company.com', '+1 555-0019', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000013', 'e4a6a31c-b631-41ee-a83d-000000000013', 6280.00, 2512.00, 942.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000be', 'e4a6a31c-b631-41ee-a83d-000000000013', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000bf', 'e4a6a31c-b631-41ee-a83d-000000000013', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000c0', 'e4a6a31c-b631-41ee-a83d-000000000013', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000014', 'rachel.martin@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000014', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000014', 'b2a4a31c-b631-41ee-a83d-000000000014', 'EMP-020', 'Rachel', 'Martin', 'rachel.martin@company.com', '+1 555-0020', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000014', 'e4a6a31c-b631-41ee-a83d-000000000014', 6400.00, 2560.00, 960.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000c8', 'e4a6a31c-b631-41ee-a83d-000000000014', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000c9', 'e4a6a31c-b631-41ee-a83d-000000000014', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000ca', 'e4a6a31c-b631-41ee-a83d-000000000014', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000015', 'sam.lee@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000015', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000015', 'b2a4a31c-b631-41ee-a83d-000000000015', 'EMP-021', 'Sam', 'Lee', 'sam.lee@company.com', '+1 555-0021', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Senior Software Engineer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000015', 'e4a6a31c-b631-41ee-a83d-000000000015', 6520.00, 2608.00, 978.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000d2', 'e4a6a31c-b631-41ee-a83d-000000000015', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000d3', 'e4a6a31c-b631-41ee-a83d-000000000015', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000d4', 'e4a6a31c-b631-41ee-a83d-000000000015', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000016', 'tina.perez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000016', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000016', 'b2a4a31c-b631-41ee-a83d-000000000016', 'EMP-022', 'Tina', 'Perez', 'tina.perez@company.com', '+1 555-0022', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000016', 'e4a6a31c-b631-41ee-a83d-000000000016', 6640.00, 2656.00, 996.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000dc', 'e4a6a31c-b631-41ee-a83d-000000000016', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000dd', 'e4a6a31c-b631-41ee-a83d-000000000016', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000de', 'e4a6a31c-b631-41ee-a83d-000000000016', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000017', 'victor.thompson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000017', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000017', 'b2a4a31c-b631-41ee-a83d-000000000017', 'EMP-023', 'Victor', 'Thompson', 'victor.thompson@company.com', '+1 555-0023', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000017', 'e4a6a31c-b631-41ee-a83d-000000000017', 6760.00, 2704.00, 1014.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000e6', 'e4a6a31c-b631-41ee-a83d-000000000017', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000e7', 'e4a6a31c-b631-41ee-a83d-000000000017', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000e8', 'e4a6a31c-b631-41ee-a83d-000000000017', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000018', 'wendy.white@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000018', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000018', 'b2a4a31c-b631-41ee-a83d-000000000018', 'EMP-024', 'Wendy', 'White', 'wendy.white@company.com', '+1 555-0024', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000018', 'e4a6a31c-b631-41ee-a83d-000000000018', 6880.00, 2752.00, 1032.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000f0', 'e4a6a31c-b631-41ee-a83d-000000000018', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000f1', 'e4a6a31c-b631-41ee-a83d-000000000018', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000f2', 'e4a6a31c-b631-41ee-a83d-000000000018', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000019', 'xavier.harris@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000019', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000019', 'b2a4a31c-b631-41ee-a83d-000000000019', 'EMP-025', 'Xavier', 'Harris', 'xavier.harris@company.com', '+1 555-0025', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000019', 'e4a6a31c-b631-41ee-a83d-000000000019', 7000.00, 2800.00, 1050.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000fa', 'e4a6a31c-b631-41ee-a83d-000000000019', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000fb', 'e4a6a31c-b631-41ee-a83d-000000000019', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000000fc', 'e4a6a31c-b631-41ee-a83d-000000000019', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001a', 'yolanda.sanchez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001a', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001a', 'b2a4a31c-b631-41ee-a83d-00000000001a', 'EMP-026', 'Yolanda', 'Sanchez', 'yolanda.sanchez@company.com', '+1 555-0026', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001a', 'e4a6a31c-b631-41ee-a83d-00000000001a', 7120.00, 2848.00, 1068.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000104', 'e4a6a31c-b631-41ee-a83d-00000000001a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000105', 'e4a6a31c-b631-41ee-a83d-00000000001a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000106', 'e4a6a31c-b631-41ee-a83d-00000000001a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001b', 'zach.clark@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001b', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001b', 'b2a4a31c-b631-41ee-a83d-00000000001b', 'EMP-027', 'Zach', 'Clark', 'zach.clark@company.com', '+1 555-0027', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001b', 'e4a6a31c-b631-41ee-a83d-00000000001b', 7240.00, 2896.00, 1086.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000010e', 'e4a6a31c-b631-41ee-a83d-00000000001b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000010f', 'e4a6a31c-b631-41ee-a83d-00000000001b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000110', 'e4a6a31c-b631-41ee-a83d-00000000001b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001c', 'arthur.ramirez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001c', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001c', 'b2a4a31c-b631-41ee-a83d-00000000001c', 'EMP-028', 'Arthur', 'Ramirez', 'arthur.ramirez@company.com', '+1 555-0028', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001c', 'e4a6a31c-b631-41ee-a83d-00000000001c', 7360.00, 2944.00, 1104.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000118', 'e4a6a31c-b631-41ee-a83d-00000000001c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000119', 'e4a6a31c-b631-41ee-a83d-00000000001c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000011a', 'e4a6a31c-b631-41ee-a83d-00000000001c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001d', 'beatrice.lewis@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001d', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001d', 'b2a4a31c-b631-41ee-a83d-00000000001d', 'EMP-029', 'Beatrice', 'Lewis', 'beatrice.lewis@company.com', '+1 555-0029', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001d', 'e4a6a31c-b631-41ee-a83d-00000000001d', 7480.00, 2992.00, 1122.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000122', 'e4a6a31c-b631-41ee-a83d-00000000001d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000123', 'e4a6a31c-b631-41ee-a83d-00000000001d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000124', 'e4a6a31c-b631-41ee-a83d-00000000001d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001e', 'connor.robinson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001e', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001e', 'b2a4a31c-b631-41ee-a83d-00000000001e', 'EMP-030', 'Connor', 'Robinson', 'connor.robinson@company.com', '+1 555-0030', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001e', 'e4a6a31c-b631-41ee-a83d-00000000001e', 7600.00, 3040.00, 1140.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000012c', 'e4a6a31c-b631-41ee-a83d-00000000001e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000012d', 'e4a6a31c-b631-41ee-a83d-00000000001e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000012e', 'e4a6a31c-b631-41ee-a83d-00000000001e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001f', 'diana.walker@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000001f', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000001f', 'b2a4a31c-b631-41ee-a83d-00000000001f', 'EMP-031', 'Diana', 'Walker', 'diana.walker@company.com', '+1 555-0031', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000001f', 'e4a6a31c-b631-41ee-a83d-00000000001f', 7720.00, 3088.00, 1158.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000136', 'e4a6a31c-b631-41ee-a83d-00000000001f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000137', 'e4a6a31c-b631-41ee-a83d-00000000001f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000138', 'e4a6a31c-b631-41ee-a83d-00000000001f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000020', 'ethan.young@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000020', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000020', 'b2a4a31c-b631-41ee-a83d-000000000020', 'EMP-032', 'Ethan', 'Young', 'ethan.young@company.com', '+1 555-0032', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000020', 'e4a6a31c-b631-41ee-a83d-000000000020', 7840.00, 3136.00, 1176.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000140', 'e4a6a31c-b631-41ee-a83d-000000000020', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000141', 'e4a6a31c-b631-41ee-a83d-000000000020', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000142', 'e4a6a31c-b631-41ee-a83d-000000000020', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000021', 'fiona.allen@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000021', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000021', 'b2a4a31c-b631-41ee-a83d-000000000021', 'EMP-033', 'Fiona', 'Allen', 'fiona.allen@company.com', '+1 555-0033', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000021', 'e4a6a31c-b631-41ee-a83d-000000000021', 7960.00, 3184.00, 1194.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000014a', 'e4a6a31c-b631-41ee-a83d-000000000021', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000014b', 'e4a6a31c-b631-41ee-a83d-000000000021', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000014c', 'e4a6a31c-b631-41ee-a83d-000000000021', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000022', 'george.king@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000022', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000022', 'b2a4a31c-b631-41ee-a83d-000000000022', 'EMP-034', 'George', 'King', 'george.king@company.com', '+1 555-0034', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000022', 'e4a6a31c-b631-41ee-a83d-000000000022', 8080.00, 3232.00, 1212.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000154', 'e4a6a31c-b631-41ee-a83d-000000000022', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000155', 'e4a6a31c-b631-41ee-a83d-000000000022', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000156', 'e4a6a31c-b631-41ee-a83d-000000000022', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000023', 'hannah.wright@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000023', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000023', 'b2a4a31c-b631-41ee-a83d-000000000023', 'EMP-035', 'Hannah', 'Wright', 'hannah.wright@company.com', '+1 555-0035', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000023', 'e4a6a31c-b631-41ee-a83d-000000000023', 8200.00, 3280.00, 1230.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000015e', 'e4a6a31c-b631-41ee-a83d-000000000023', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000015f', 'e4a6a31c-b631-41ee-a83d-000000000023', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000160', 'e4a6a31c-b631-41ee-a83d-000000000023', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000024', 'ian.scott@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000024', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000024', 'b2a4a31c-b631-41ee-a83d-000000000024', 'EMP-036', 'Ian', 'Scott', 'ian.scott@company.com', '+1 555-0036', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Senior Software Engineer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000024', 'e4a6a31c-b631-41ee-a83d-000000000024', 8320.00, 3328.00, 1248.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000168', 'e4a6a31c-b631-41ee-a83d-000000000024', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000169', 'e4a6a31c-b631-41ee-a83d-000000000024', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000016a', 'e4a6a31c-b631-41ee-a83d-000000000024', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000025', 'julia.torres@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000025', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000025', 'b2a4a31c-b631-41ee-a83d-000000000025', 'EMP-037', 'Julia', 'Torres', 'julia.torres@company.com', '+1 555-0037', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000025', 'e4a6a31c-b631-41ee-a83d-000000000025', 8440.00, 3376.00, 1266.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000172', 'e4a6a31c-b631-41ee-a83d-000000000025', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000173', 'e4a6a31c-b631-41ee-a83d-000000000025', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000174', 'e4a6a31c-b631-41ee-a83d-000000000025', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000026', 'kevin.nguyen@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000026', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000026', 'b2a4a31c-b631-41ee-a83d-000000000026', 'EMP-038', 'Kevin', 'Nguyen', 'kevin.nguyen@company.com', '+1 555-0038', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000026', 'e4a6a31c-b631-41ee-a83d-000000000026', 8560.00, 3424.00, 1284.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000017c', 'e4a6a31c-b631-41ee-a83d-000000000026', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000017d', 'e4a6a31c-b631-41ee-a83d-000000000026', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000017e', 'e4a6a31c-b631-41ee-a83d-000000000026', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000027', 'laura.hill@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000027', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000027', 'b2a4a31c-b631-41ee-a83d-000000000027', 'EMP-039', 'Laura', 'Hill', 'laura.hill@company.com', '+1 555-0039', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000027', 'e4a6a31c-b631-41ee-a83d-000000000027', 8680.00, 3472.00, 1302.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000186', 'e4a6a31c-b631-41ee-a83d-000000000027', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000187', 'e4a6a31c-b631-41ee-a83d-000000000027', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000188', 'e4a6a31c-b631-41ee-a83d-000000000027', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000028', 'marcus.flores@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000028', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000028', 'b2a4a31c-b631-41ee-a83d-000000000028', 'EMP-040', 'Marcus', 'Flores', 'marcus.flores@company.com', '+1 555-0040', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000028', 'e4a6a31c-b631-41ee-a83d-000000000028', 8800.00, 3520.00, 1320.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000190', 'e4a6a31c-b631-41ee-a83d-000000000028', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000191', 'e4a6a31c-b631-41ee-a83d-000000000028', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000192', 'e4a6a31c-b631-41ee-a83d-000000000028', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000029', 'nora.green@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000029', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000029', 'b2a4a31c-b631-41ee-a83d-000000000029', 'EMP-041', 'Nora', 'Green', 'nora.green@company.com', '+1 555-0041', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000029', 'e4a6a31c-b631-41ee-a83d-000000000029', 8920.00, 3568.00, 1338.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000019a', 'e4a6a31c-b631-41ee-a83d-000000000029', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000019b', 'e4a6a31c-b631-41ee-a83d-000000000029', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000019c', 'e4a6a31c-b631-41ee-a83d-000000000029', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002a', 'oscar.adams@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002a', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002a', 'b2a4a31c-b631-41ee-a83d-00000000002a', 'EMP-042', 'Oscar', 'Adams', 'oscar.adams@company.com', '+1 555-0042', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002a', 'e4a6a31c-b631-41ee-a83d-00000000002a', 9040.00, 3616.00, 1356.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001a4', 'e4a6a31c-b631-41ee-a83d-00000000002a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001a5', 'e4a6a31c-b631-41ee-a83d-00000000002a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001a6', 'e4a6a31c-b631-41ee-a83d-00000000002a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002b', 'penelope.nelson@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002b', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002b', 'b2a4a31c-b631-41ee-a83d-00000000002b', 'EMP-043', 'Penelope', 'Nelson', 'penelope.nelson@company.com', '+1 555-0043', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002b', 'e4a6a31c-b631-41ee-a83d-00000000002b', 9160.00, 3664.00, 1374.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ae', 'e4a6a31c-b631-41ee-a83d-00000000002b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001af', 'e4a6a31c-b631-41ee-a83d-00000000002b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001b0', 'e4a6a31c-b631-41ee-a83d-00000000002b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002c', 'quincy.baker@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002c', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002c', 'b2a4a31c-b631-41ee-a83d-00000000002c', 'EMP-044', 'Quincy', 'Baker', 'quincy.baker@company.com', '+1 555-0044', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002c', 'e4a6a31c-b631-41ee-a83d-00000000002c', 9280.00, 3712.00, 1392.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001b8', 'e4a6a31c-b631-41ee-a83d-00000000002c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001b9', 'e4a6a31c-b631-41ee-a83d-00000000002c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ba', 'e4a6a31c-b631-41ee-a83d-00000000002c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002d', 'rebecca.hall@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002d', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002d', 'b2a4a31c-b631-41ee-a83d-00000000002d', 'EMP-045', 'Rebecca', 'Hall', 'rebecca.hall@company.com', '+1 555-0045', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002d', 'e4a6a31c-b631-41ee-a83d-00000000002d', 9400.00, 3760.00, 1410.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001c2', 'e4a6a31c-b631-41ee-a83d-00000000002d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001c3', 'e4a6a31c-b631-41ee-a83d-00000000002d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001c4', 'e4a6a31c-b631-41ee-a83d-00000000002d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002e', 'steven.rivera@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002e', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002e', 'b2a4a31c-b631-41ee-a83d-00000000002e', 'EMP-046', 'Steven', 'Rivera', 'steven.rivera@company.com', '+1 555-0046', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002e', 'e4a6a31c-b631-41ee-a83d-00000000002e', 9520.00, 3808.00, 1428.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001cc', 'e4a6a31c-b631-41ee-a83d-00000000002e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001cd', 'e4a6a31c-b631-41ee-a83d-00000000002e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ce', 'e4a6a31c-b631-41ee-a83d-00000000002e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002f', 'teresa.campbell@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000002f', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000002f', 'b2a4a31c-b631-41ee-a83d-00000000002f', 'EMP-047', 'Teresa', 'Campbell', 'teresa.campbell@company.com', '+1 555-0047', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000002f', 'e4a6a31c-b631-41ee-a83d-00000000002f', 9640.00, 3856.00, 1446.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001d6', 'e4a6a31c-b631-41ee-a83d-00000000002f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001d7', 'e4a6a31c-b631-41ee-a83d-00000000002f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001d8', 'e4a6a31c-b631-41ee-a83d-00000000002f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000030', 'ulysses.mitchell@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000030', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000030', 'b2a4a31c-b631-41ee-a83d-000000000030', 'EMP-048', 'Ulysses', 'Mitchell', 'ulysses.mitchell@company.com', '+1 555-0048', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000030', 'e4a6a31c-b631-41ee-a83d-000000000030', 9760.00, 3904.00, 1464.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001e0', 'e4a6a31c-b631-41ee-a83d-000000000030', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001e1', 'e4a6a31c-b631-41ee-a83d-000000000030', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001e2', 'e4a6a31c-b631-41ee-a83d-000000000030', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000031', 'valerie.carter@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000031', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000031', 'b2a4a31c-b631-41ee-a83d-000000000031', 'EMP-049', 'Valerie', 'Carter', 'valerie.carter@company.com', '+1 555-0049', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000031', 'e4a6a31c-b631-41ee-a83d-000000000031', 9880.00, 3952.00, 1482.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ea', 'e4a6a31c-b631-41ee-a83d-000000000031', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001eb', 'e4a6a31c-b631-41ee-a83d-000000000031', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ec', 'e4a6a31c-b631-41ee-a83d-000000000031', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000032', 'walter.roberts@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000032', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000032', 'b2a4a31c-b631-41ee-a83d-000000000032', 'EMP-050', 'Walter', 'Roberts', 'walter.roberts@company.com', '+1 555-0050', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000032', 'e4a6a31c-b631-41ee-a83d-000000000032', 10000.00, 4000.00, 1500.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001f4', 'e4a6a31c-b631-41ee-a83d-000000000032', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001f5', 'e4a6a31c-b631-41ee-a83d-000000000032', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001f6', 'e4a6a31c-b631-41ee-a83d-000000000032', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000033', 'xena.gomez@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000033', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000033', 'b2a4a31c-b631-41ee-a83d-000000000033', 'EMP-051', 'Xena', 'Gomez', 'xena.gomez@company.com', '+1 555-0051', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Senior Software Engineer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000033', 'e4a6a31c-b631-41ee-a83d-000000000033', 10120.00, 4048.00, 1518.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001fe', 'e4a6a31c-b631-41ee-a83d-000000000033', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-0000000001ff', 'e4a6a31c-b631-41ee-a83d-000000000033', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000200', 'e4a6a31c-b631-41ee-a83d-000000000033', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000034', 'yosef.phillips@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000034', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000034', 'b2a4a31c-b631-41ee-a83d-000000000034', 'EMP-052', 'Yosef', 'Phillips', 'yosef.phillips@company.com', '+1 555-0052', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000034', 'e4a6a31c-b631-41ee-a83d-000000000034', 10240.00, 4096.00, 1536.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000208', 'e4a6a31c-b631-41ee-a83d-000000000034', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000209', 'e4a6a31c-b631-41ee-a83d-000000000034', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000020a', 'e4a6a31c-b631-41ee-a83d-000000000034', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000035', 'zoe.evans@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000035', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000035', 'b2a4a31c-b631-41ee-a83d-000000000035', 'EMP-053', 'Zoe', 'Evans', 'zoe.evans@company.com', '+1 555-0053', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000035', 'e4a6a31c-b631-41ee-a83d-000000000035', 10360.00, 4144.00, 1554.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000212', 'e4a6a31c-b631-41ee-a83d-000000000035', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000213', 'e4a6a31c-b631-41ee-a83d-000000000035', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000214', 'e4a6a31c-b631-41ee-a83d-000000000035', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000036', 'albert.turner@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000036', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000036', 'b2a4a31c-b631-41ee-a83d-000000000036', 'EMP-054', 'Albert', 'Turner', 'albert.turner@company.com', '+1 555-0054', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000036', 'e4a6a31c-b631-41ee-a83d-000000000036', 10480.00, 4192.00, 1572.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000021c', 'e4a6a31c-b631-41ee-a83d-000000000036', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000021d', 'e4a6a31c-b631-41ee-a83d-000000000036', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000021e', 'e4a6a31c-b631-41ee-a83d-000000000036', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000037', 'brenda.diaz@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000037', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000037', 'b2a4a31c-b631-41ee-a83d-000000000037', 'EMP-055', 'Brenda', 'Diaz', 'brenda.diaz@company.com', '+1 555-0055', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000037', 'e4a6a31c-b631-41ee-a83d-000000000037', 10600.00, 4240.00, 1590.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000226', 'e4a6a31c-b631-41ee-a83d-000000000037', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000227', 'e4a6a31c-b631-41ee-a83d-000000000037', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000228', 'e4a6a31c-b631-41ee-a83d-000000000037', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000038', 'carl.parker@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000038', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000038', 'b2a4a31c-b631-41ee-a83d-000000000038', 'EMP-056', 'Carl', 'Parker', 'carl.parker@company.com', '+1 555-0056', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000038', 'e4a6a31c-b631-41ee-a83d-000000000038', 10720.00, 4288.00, 1608.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000230', 'e4a6a31c-b631-41ee-a83d-000000000038', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000231', 'e4a6a31c-b631-41ee-a83d-000000000038', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000232', 'e4a6a31c-b631-41ee-a83d-000000000038', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000039', 'donna.cruz@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000039', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000039', 'b2a4a31c-b631-41ee-a83d-000000000039', 'EMP-057', 'Donna', 'Cruz', 'donna.cruz@company.com', '+1 555-0057', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000039', 'e4a6a31c-b631-41ee-a83d-000000000039', 10840.00, 4336.00, 1626.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000023a', 'e4a6a31c-b631-41ee-a83d-000000000039', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000023b', 'e4a6a31c-b631-41ee-a83d-000000000039', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000023c', 'e4a6a31c-b631-41ee-a83d-000000000039', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003a', 'edward.edwards@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003a', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003a', 'b2a4a31c-b631-41ee-a83d-00000000003a', 'EMP-058', 'Edward', 'Edwards', 'edward.edwards@company.com', '+1 555-0058', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003a', 'e4a6a31c-b631-41ee-a83d-00000000003a', 10960.00, 4384.00, 1644.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000244', 'e4a6a31c-b631-41ee-a83d-00000000003a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000245', 'e4a6a31c-b631-41ee-a83d-00000000003a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000246', 'e4a6a31c-b631-41ee-a83d-00000000003a', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003b', 'florence.collins@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003b', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003b', 'b2a4a31c-b631-41ee-a83d-00000000003b', 'EMP-059', 'Florence', 'Collins', 'florence.collins@company.com', '+1 555-0059', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003b', 'e4a6a31c-b631-41ee-a83d-00000000003b', 11080.00, 4432.00, 1662.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000024e', 'e4a6a31c-b631-41ee-a83d-00000000003b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000024f', 'e4a6a31c-b631-41ee-a83d-00000000003b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000250', 'e4a6a31c-b631-41ee-a83d-00000000003b', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003c', 'gary.reyes@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003c', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003c', 'b2a4a31c-b631-41ee-a83d-00000000003c', 'EMP-060', 'Gary', 'Reyes', 'gary.reyes@company.com', '+1 555-0060', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003c', 'e4a6a31c-b631-41ee-a83d-00000000003c', 11200.00, 4480.00, 1680.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000258', 'e4a6a31c-b631-41ee-a83d-00000000003c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000259', 'e4a6a31c-b631-41ee-a83d-00000000003c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000025a', 'e4a6a31c-b631-41ee-a83d-00000000003c', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003d', 'helen.stewart@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003d', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003d', 'b2a4a31c-b631-41ee-a83d-00000000003d', 'EMP-061', 'Helen', 'Stewart', 'helen.stewart@company.com', '+1 555-0061', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002', 'Associate Developer', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000005') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003d', 'e4a6a31c-b631-41ee-a83d-00000000003d', 11320.00, 4528.00, 1698.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000262', 'e4a6a31c-b631-41ee-a83d-00000000003d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000263', 'e4a6a31c-b631-41ee-a83d-00000000003d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000264', 'e4a6a31c-b631-41ee-a83d-00000000003d', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003e', 'logan.morris@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003e', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003e', 'b2a4a31c-b631-41ee-a83d-00000000003e', 'EMP-062', 'Logan', 'Morris', 'logan.morris@company.com', '+1 555-0062', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003', 'Product Specialist', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000006') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003e', 'e4a6a31c-b631-41ee-a83d-00000000003e', 11440.00, 4576.00, 1716.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000026c', 'e4a6a31c-b631-41ee-a83d-00000000003e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000026d', 'e4a6a31c-b631-41ee-a83d-00000000003e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000026e', 'e4a6a31c-b631-41ee-a83d-00000000003e', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003f', 'ruby.morales@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-00000000003f', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-00000000003f', 'b2a4a31c-b631-41ee-a83d-00000000003f', 'EMP-063', 'Ruby', 'Morales', 'ruby.morales@company.com', '+1 555-0063', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004', 'Financial Analyst', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000007') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-00000000003f', 'e4a6a31c-b631-41ee-a83d-00000000003f', 11560.00, 4624.00, 1734.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000276', 'e4a6a31c-b631-41ee-a83d-00000000003f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000277', 'e4a6a31c-b631-41ee-a83d-00000000003f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000278', 'e4a6a31c-b631-41ee-a83d-00000000003f', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000040', 'austin.murphy@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000040', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000040', 'b2a4a31c-b631-41ee-a83d-000000000040', 'EMP-064', 'Austin', 'Murphy', 'austin.murphy@company.com', '+1 555-0064', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005', 'Marketing Representative', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000008') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000040', 'e4a6a31c-b631-41ee-a83d-000000000040', 11680.00, 4672.00, 1752.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000280', 'e4a6a31c-b631-41ee-a83d-000000000040', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000281', 'e4a6a31c-b631-41ee-a83d-000000000040', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-000000000282', 'e4a6a31c-b631-41ee-a83d-000000000040', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO users (id, email, password_hash, is_active) VALUES
('b2a4a31c-b631-41ee-a83d-000000000041', 'clara.cook@company.com', '$2b$10$dummyhashpassword123', true) ON CONFLICT (id) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
('b2a4a31c-b631-41ee-a83d-000000000041', 'd1a3a31c-b631-41ee-a83d-6b5dfef6e804') ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO employees (id, user_id, employee_id, first_name, last_name, email, phone, department_id, designation, joining_date, status, reporting_manager_id) VALUES
('e4a6a31c-b631-41ee-a83d-000000000041', 'b2a4a31c-b631-41ee-a83d-000000000041', 'EMP-065', 'Clara', 'Cook', 'clara.cook@company.com', '+1 555-0065', 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001', 'HR Associate', '2023-06-01', 'ACTIVE', 'e4a6a31c-b631-41ee-a83d-000000000004') ON CONFLICT (id) DO NOTHING;

INSERT INTO salary_structures (id, employee_id, base_salary, hra, lta) VALUES
('b9a2a31c-b631-41ee-a83d-000000000041', 'e4a6a31c-b631-41ee-a83d-000000000041', 11800.00, 4720.00, 1770.00) ON CONFLICT (id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000028a', 'e4a6a31c-b631-41ee-a83d-000000000041', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 12.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000028b', 'e4a6a31c-b631-41ee-a83d-000000000041', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6e', 10.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

INSERT INTO leave_balances (id, employee_id, leave_type_id, allocated, used) VALUES
('a7b3c4d5-b631-41ee-a83d-00000000028c', 'e4a6a31c-b631-41ee-a83d-000000000041', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6f', 18.0, 0.0) ON CONFLICT (employee_id, leave_type_id) DO NOTHING;

-- Link managers to departments
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-000000000002' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f001';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-000000000004' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f002';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-000000000005' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f003';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-000000000006' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f004';
UPDATE departments SET manager_id = 'e4a6a31c-b631-41ee-a83d-000000000007' WHERE id = 'c3a5a31c-b631-41ee-a83d-6b5dfef6f005';
