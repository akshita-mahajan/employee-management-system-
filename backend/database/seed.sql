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
('b9a2a31c-b631-41ee-a83d-000000000001', 'e4a6a31c-b631-41ee-a83d-000000000001', 41200.00, 16480.00, 6180.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000002', 'e4a6a31c-b631-41ee-a83d-000000000002', 42400.00, 16960.00, 6360.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000003', 'e4a6a31c-b631-41ee-a83d-000000000003', 43600.00, 17440.00, 6540.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000004', 'e4a6a31c-b631-41ee-a83d-000000000004', 44800.00, 17920.00, 6720.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000005', 'e4a6a31c-b631-41ee-a83d-000000000005', 46000.00, 18400.00, 6900.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000006', 'e4a6a31c-b631-41ee-a83d-000000000006', 47200.00, 18880.00, 7080.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000007', 'e4a6a31c-b631-41ee-a83d-000000000007', 48400.00, 19360.00, 7260.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000008', 'e4a6a31c-b631-41ee-a83d-000000000008', 49600.00, 19840.00, 7440.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000009', 'e4a6a31c-b631-41ee-a83d-000000000009', 50800.00, 20320.00, 7620.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000a', 'e4a6a31c-b631-41ee-a83d-00000000000a', 52000.00, 20800.00, 7800.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000b', 'e4a6a31c-b631-41ee-a83d-00000000000b', 53200.00, 21280.00, 7980.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000c', 'e4a6a31c-b631-41ee-a83d-00000000000c', 54400.00, 21760.00, 8160.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000d', 'e4a6a31c-b631-41ee-a83d-00000000000d', 55600.00, 22240.00, 8340.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000e', 'e4a6a31c-b631-41ee-a83d-00000000000e', 56800.00, 22720.00, 8520.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000000f', 'e4a6a31c-b631-41ee-a83d-00000000000f', 58000.00, 23200.00, 8700.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000010', 'e4a6a31c-b631-41ee-a83d-000000000010', 59200.00, 23680.00, 8880.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000011', 'e4a6a31c-b631-41ee-a83d-000000000011', 60400.00, 24160.00, 9060.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000012', 'e4a6a31c-b631-41ee-a83d-000000000012', 61600.00, 24640.00, 9240.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000013', 'e4a6a31c-b631-41ee-a83d-000000000013', 62800.00, 25120.00, 9420.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000014', 'e4a6a31c-b631-41ee-a83d-000000000014', 64000.00, 25600.00, 9600.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000015', 'e4a6a31c-b631-41ee-a83d-000000000015', 65200.00, 26080.00, 9780.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000016', 'e4a6a31c-b631-41ee-a83d-000000000016', 66400.00, 26560.00, 9960.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000017', 'e4a6a31c-b631-41ee-a83d-000000000017', 67600.00, 27040.00, 10140.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000018', 'e4a6a31c-b631-41ee-a83d-000000000018', 68800.00, 27520.00, 10320.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000019', 'e4a6a31c-b631-41ee-a83d-000000000019', 70000.00, 28000.00, 10500.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001a', 'e4a6a31c-b631-41ee-a83d-00000000001a', 71200.00, 28480.00, 10680.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001b', 'e4a6a31c-b631-41ee-a83d-00000000001b', 72400.00, 28960.00, 10860.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001c', 'e4a6a31c-b631-41ee-a83d-00000000001c', 73600.00, 29440.00, 11040.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001d', 'e4a6a31c-b631-41ee-a83d-00000000001d', 74800.00, 29920.00, 11220.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001e', 'e4a6a31c-b631-41ee-a83d-00000000001e', 76000.00, 30400.00, 11400.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000001f', 'e4a6a31c-b631-41ee-a83d-00000000001f', 77200.00, 30880.00, 11580.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000020', 'e4a6a31c-b631-41ee-a83d-000000000020', 78400.00, 31360.00, 11760.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000021', 'e4a6a31c-b631-41ee-a83d-000000000021', 79600.00, 31840.00, 11940.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000022', 'e4a6a31c-b631-41ee-a83d-000000000022', 80800.00, 32320.00, 12120.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000023', 'e4a6a31c-b631-41ee-a83d-000000000023', 82000.00, 32800.00, 12300.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000024', 'e4a6a31c-b631-41ee-a83d-000000000024', 83200.00, 33280.00, 12480.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000025', 'e4a6a31c-b631-41ee-a83d-000000000025', 84400.00, 33760.00, 12660.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000026', 'e4a6a31c-b631-41ee-a83d-000000000026', 85600.00, 34240.00, 12840.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000027', 'e4a6a31c-b631-41ee-a83d-000000000027', 86800.00, 34720.00, 13020.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000028', 'e4a6a31c-b631-41ee-a83d-000000000028', 88000.00, 35200.00, 13200.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000029', 'e4a6a31c-b631-41ee-a83d-000000000029', 89200.00, 35680.00, 13380.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002a', 'e4a6a31c-b631-41ee-a83d-00000000002a', 90400.00, 36160.00, 13560.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002b', 'e4a6a31c-b631-41ee-a83d-00000000002b', 91600.00, 36640.00, 13740.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002c', 'e4a6a31c-b631-41ee-a83d-00000000002c', 92800.00, 37120.00, 13920.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002d', 'e4a6a31c-b631-41ee-a83d-00000000002d', 94000.00, 37600.00, 14100.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002e', 'e4a6a31c-b631-41ee-a83d-00000000002e', 95200.00, 38080.00, 14280.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000002f', 'e4a6a31c-b631-41ee-a83d-00000000002f', 96400.00, 38560.00, 14460.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000030', 'e4a6a31c-b631-41ee-a83d-000000000030', 97600.00, 39040.00, 14640.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000031', 'e4a6a31c-b631-41ee-a83d-000000000031', 98800.00, 39520.00, 14820.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000032', 'e4a6a31c-b631-41ee-a83d-000000000032', 100000.00, 40000.00, 15000.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000033', 'e4a6a31c-b631-41ee-a83d-000000000033', 101200.00, 40480.00, 15180.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000034', 'e4a6a31c-b631-41ee-a83d-000000000034', 102400.00, 40960.00, 15360.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000035', 'e4a6a31c-b631-41ee-a83d-000000000035', 103600.00, 41440.00, 15540.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000036', 'e4a6a31c-b631-41ee-a83d-000000000036', 104800.00, 41920.00, 15720.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000037', 'e4a6a31c-b631-41ee-a83d-000000000037', 106000.00, 42400.00, 15900.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000038', 'e4a6a31c-b631-41ee-a83d-000000000038', 107200.00, 42880.00, 16080.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000039', 'e4a6a31c-b631-41ee-a83d-000000000039', 108400.00, 43360.00, 16260.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003a', 'e4a6a31c-b631-41ee-a83d-00000000003a', 109600.00, 43840.00, 16440.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003b', 'e4a6a31c-b631-41ee-a83d-00000000003b', 110800.00, 44320.00, 16620.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003c', 'e4a6a31c-b631-41ee-a83d-00000000003c', 112000.00, 44800.00, 16800.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003d', 'e4a6a31c-b631-41ee-a83d-00000000003d', 113200.00, 45280.00, 16980.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003e', 'e4a6a31c-b631-41ee-a83d-00000000003e', 114400.00, 45760.00, 17160.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-00000000003f', 'e4a6a31c-b631-41ee-a83d-00000000003f', 115600.00, 46240.00, 17340.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000040', 'e4a6a31c-b631-41ee-a83d-000000000040', 116800.00, 46720.00, 17520.00) ON CONFLICT (id) DO NOTHING;

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
('b9a2a31c-b631-41ee-a83d-000000000041', 'e4a6a31c-b631-41ee-a83d-000000000041', 118000.00, 47200.00, 17700.00) ON CONFLICT (id) DO NOTHING;

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

-- 5. SEED PAYROLL RUNS AND HISTORICAL PAYSLIPS

INSERT INTO payroll_runs (id, billing_month, status, total_payout, created_at, updated_at) VALUES
('d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'May 2026', 'PROCESSED', 7385820.00, '2026-05-30 18:00:00+00', '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000064', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000001', 58716.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000064', 'Basic Salary', 'EARNING', 41200.00),
('d1a3a31c-b631-41ee-a83d-000000000064', 'House Rent Allowance (HRA)', 'EARNING', 16480.00),
('d1a3a31c-b631-41ee-a83d-000000000064', 'Leave Travel Allowance (LTA)', 'EARNING', 6180.00),
('d1a3a31c-b631-41ee-a83d-000000000064', 'Provident Fund (PF)', 'DEDUCTION', 4944.00),
('d1a3a31c-b631-41ee-a83d-000000000064', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000065', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000002', 60432.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000065', 'Basic Salary', 'EARNING', 42400.00),
('d1a3a31c-b631-41ee-a83d-000000000065', 'House Rent Allowance (HRA)', 'EARNING', 16960.00),
('d1a3a31c-b631-41ee-a83d-000000000065', 'Leave Travel Allowance (LTA)', 'EARNING', 6360.00),
('d1a3a31c-b631-41ee-a83d-000000000065', 'Provident Fund (PF)', 'DEDUCTION', 5088.00),
('d1a3a31c-b631-41ee-a83d-000000000065', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000066', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000003', 62148.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000066', 'Basic Salary', 'EARNING', 43600.00),
('d1a3a31c-b631-41ee-a83d-000000000066', 'House Rent Allowance (HRA)', 'EARNING', 17440.00),
('d1a3a31c-b631-41ee-a83d-000000000066', 'Leave Travel Allowance (LTA)', 'EARNING', 6540.00),
('d1a3a31c-b631-41ee-a83d-000000000066', 'Provident Fund (PF)', 'DEDUCTION', 5232.00),
('d1a3a31c-b631-41ee-a83d-000000000066', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000067', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000004', 63864.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000067', 'Basic Salary', 'EARNING', 44800.00),
('d1a3a31c-b631-41ee-a83d-000000000067', 'House Rent Allowance (HRA)', 'EARNING', 17920.00),
('d1a3a31c-b631-41ee-a83d-000000000067', 'Leave Travel Allowance (LTA)', 'EARNING', 6720.00),
('d1a3a31c-b631-41ee-a83d-000000000067', 'Provident Fund (PF)', 'DEDUCTION', 5376.00),
('d1a3a31c-b631-41ee-a83d-000000000067', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000068', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000005', 65580.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000068', 'Basic Salary', 'EARNING', 46000.00),
('d1a3a31c-b631-41ee-a83d-000000000068', 'House Rent Allowance (HRA)', 'EARNING', 18400.00),
('d1a3a31c-b631-41ee-a83d-000000000068', 'Leave Travel Allowance (LTA)', 'EARNING', 6900.00),
('d1a3a31c-b631-41ee-a83d-000000000068', 'Provident Fund (PF)', 'DEDUCTION', 5520.00),
('d1a3a31c-b631-41ee-a83d-000000000068', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000069', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000006', 67296.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000069', 'Basic Salary', 'EARNING', 47200.00),
('d1a3a31c-b631-41ee-a83d-000000000069', 'House Rent Allowance (HRA)', 'EARNING', 18880.00),
('d1a3a31c-b631-41ee-a83d-000000000069', 'Leave Travel Allowance (LTA)', 'EARNING', 7080.00),
('d1a3a31c-b631-41ee-a83d-000000000069', 'Provident Fund (PF)', 'DEDUCTION', 5664.00),
('d1a3a31c-b631-41ee-a83d-000000000069', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006a', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000007', 69012.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006a', 'Basic Salary', 'EARNING', 48400.00),
('d1a3a31c-b631-41ee-a83d-00000000006a', 'House Rent Allowance (HRA)', 'EARNING', 19360.00),
('d1a3a31c-b631-41ee-a83d-00000000006a', 'Leave Travel Allowance (LTA)', 'EARNING', 7260.00),
('d1a3a31c-b631-41ee-a83d-00000000006a', 'Provident Fund (PF)', 'DEDUCTION', 5808.00),
('d1a3a31c-b631-41ee-a83d-00000000006a', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006b', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000008', 70728.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006b', 'Basic Salary', 'EARNING', 49600.00),
('d1a3a31c-b631-41ee-a83d-00000000006b', 'House Rent Allowance (HRA)', 'EARNING', 19840.00),
('d1a3a31c-b631-41ee-a83d-00000000006b', 'Leave Travel Allowance (LTA)', 'EARNING', 7440.00),
('d1a3a31c-b631-41ee-a83d-00000000006b', 'Provident Fund (PF)', 'DEDUCTION', 5952.00),
('d1a3a31c-b631-41ee-a83d-00000000006b', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006c', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000009', 72444.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006c', 'Basic Salary', 'EARNING', 50800.00),
('d1a3a31c-b631-41ee-a83d-00000000006c', 'House Rent Allowance (HRA)', 'EARNING', 20320.00),
('d1a3a31c-b631-41ee-a83d-00000000006c', 'Leave Travel Allowance (LTA)', 'EARNING', 7620.00),
('d1a3a31c-b631-41ee-a83d-00000000006c', 'Provident Fund (PF)', 'DEDUCTION', 6096.00),
('d1a3a31c-b631-41ee-a83d-00000000006c', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006d', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000a', 74160.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006d', 'Basic Salary', 'EARNING', 52000.00),
('d1a3a31c-b631-41ee-a83d-00000000006d', 'House Rent Allowance (HRA)', 'EARNING', 20800.00),
('d1a3a31c-b631-41ee-a83d-00000000006d', 'Leave Travel Allowance (LTA)', 'EARNING', 7800.00),
('d1a3a31c-b631-41ee-a83d-00000000006d', 'Provident Fund (PF)', 'DEDUCTION', 6240.00),
('d1a3a31c-b631-41ee-a83d-00000000006d', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006e', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000b', 75876.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006e', 'Basic Salary', 'EARNING', 53200.00),
('d1a3a31c-b631-41ee-a83d-00000000006e', 'House Rent Allowance (HRA)', 'EARNING', 21280.00),
('d1a3a31c-b631-41ee-a83d-00000000006e', 'Leave Travel Allowance (LTA)', 'EARNING', 7980.00),
('d1a3a31c-b631-41ee-a83d-00000000006e', 'Provident Fund (PF)', 'DEDUCTION', 6384.00),
('d1a3a31c-b631-41ee-a83d-00000000006e', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006f', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000c', 77592.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000006f', 'Basic Salary', 'EARNING', 54400.00),
('d1a3a31c-b631-41ee-a83d-00000000006f', 'House Rent Allowance (HRA)', 'EARNING', 21760.00),
('d1a3a31c-b631-41ee-a83d-00000000006f', 'Leave Travel Allowance (LTA)', 'EARNING', 8160.00),
('d1a3a31c-b631-41ee-a83d-00000000006f', 'Provident Fund (PF)', 'DEDUCTION', 6528.00),
('d1a3a31c-b631-41ee-a83d-00000000006f', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000070', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000d', 79308.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000070', 'Basic Salary', 'EARNING', 55600.00),
('d1a3a31c-b631-41ee-a83d-000000000070', 'House Rent Allowance (HRA)', 'EARNING', 22240.00),
('d1a3a31c-b631-41ee-a83d-000000000070', 'Leave Travel Allowance (LTA)', 'EARNING', 8340.00),
('d1a3a31c-b631-41ee-a83d-000000000070', 'Provident Fund (PF)', 'DEDUCTION', 6672.00),
('d1a3a31c-b631-41ee-a83d-000000000070', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000071', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000e', 81024.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000071', 'Basic Salary', 'EARNING', 56800.00),
('d1a3a31c-b631-41ee-a83d-000000000071', 'House Rent Allowance (HRA)', 'EARNING', 22720.00),
('d1a3a31c-b631-41ee-a83d-000000000071', 'Leave Travel Allowance (LTA)', 'EARNING', 8520.00),
('d1a3a31c-b631-41ee-a83d-000000000071', 'Provident Fund (PF)', 'DEDUCTION', 6816.00),
('d1a3a31c-b631-41ee-a83d-000000000071', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000072', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000000f', 82740.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000072', 'Basic Salary', 'EARNING', 58000.00),
('d1a3a31c-b631-41ee-a83d-000000000072', 'House Rent Allowance (HRA)', 'EARNING', 23200.00),
('d1a3a31c-b631-41ee-a83d-000000000072', 'Leave Travel Allowance (LTA)', 'EARNING', 8700.00),
('d1a3a31c-b631-41ee-a83d-000000000072', 'Provident Fund (PF)', 'DEDUCTION', 6960.00),
('d1a3a31c-b631-41ee-a83d-000000000072', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000073', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000010', 84456.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000073', 'Basic Salary', 'EARNING', 59200.00),
('d1a3a31c-b631-41ee-a83d-000000000073', 'House Rent Allowance (HRA)', 'EARNING', 23680.00),
('d1a3a31c-b631-41ee-a83d-000000000073', 'Leave Travel Allowance (LTA)', 'EARNING', 8880.00),
('d1a3a31c-b631-41ee-a83d-000000000073', 'Provident Fund (PF)', 'DEDUCTION', 7104.00),
('d1a3a31c-b631-41ee-a83d-000000000073', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000074', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000011', 86172.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000074', 'Basic Salary', 'EARNING', 60400.00),
('d1a3a31c-b631-41ee-a83d-000000000074', 'House Rent Allowance (HRA)', 'EARNING', 24160.00),
('d1a3a31c-b631-41ee-a83d-000000000074', 'Leave Travel Allowance (LTA)', 'EARNING', 9060.00),
('d1a3a31c-b631-41ee-a83d-000000000074', 'Provident Fund (PF)', 'DEDUCTION', 7248.00),
('d1a3a31c-b631-41ee-a83d-000000000074', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000075', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000012', 87888.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000075', 'Basic Salary', 'EARNING', 61600.00),
('d1a3a31c-b631-41ee-a83d-000000000075', 'House Rent Allowance (HRA)', 'EARNING', 24640.00),
('d1a3a31c-b631-41ee-a83d-000000000075', 'Leave Travel Allowance (LTA)', 'EARNING', 9240.00),
('d1a3a31c-b631-41ee-a83d-000000000075', 'Provident Fund (PF)', 'DEDUCTION', 7392.00),
('d1a3a31c-b631-41ee-a83d-000000000075', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000076', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000013', 89604.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000076', 'Basic Salary', 'EARNING', 62800.00),
('d1a3a31c-b631-41ee-a83d-000000000076', 'House Rent Allowance (HRA)', 'EARNING', 25120.00),
('d1a3a31c-b631-41ee-a83d-000000000076', 'Leave Travel Allowance (LTA)', 'EARNING', 9420.00),
('d1a3a31c-b631-41ee-a83d-000000000076', 'Provident Fund (PF)', 'DEDUCTION', 7536.00),
('d1a3a31c-b631-41ee-a83d-000000000076', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000077', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000014', 91320.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000077', 'Basic Salary', 'EARNING', 64000.00),
('d1a3a31c-b631-41ee-a83d-000000000077', 'House Rent Allowance (HRA)', 'EARNING', 25600.00),
('d1a3a31c-b631-41ee-a83d-000000000077', 'Leave Travel Allowance (LTA)', 'EARNING', 9600.00),
('d1a3a31c-b631-41ee-a83d-000000000077', 'Provident Fund (PF)', 'DEDUCTION', 7680.00),
('d1a3a31c-b631-41ee-a83d-000000000077', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000078', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000015', 93036.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000078', 'Basic Salary', 'EARNING', 65200.00),
('d1a3a31c-b631-41ee-a83d-000000000078', 'House Rent Allowance (HRA)', 'EARNING', 26080.00),
('d1a3a31c-b631-41ee-a83d-000000000078', 'Leave Travel Allowance (LTA)', 'EARNING', 9780.00),
('d1a3a31c-b631-41ee-a83d-000000000078', 'Provident Fund (PF)', 'DEDUCTION', 7824.00),
('d1a3a31c-b631-41ee-a83d-000000000078', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000079', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000016', 94752.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000079', 'Basic Salary', 'EARNING', 66400.00),
('d1a3a31c-b631-41ee-a83d-000000000079', 'House Rent Allowance (HRA)', 'EARNING', 26560.00),
('d1a3a31c-b631-41ee-a83d-000000000079', 'Leave Travel Allowance (LTA)', 'EARNING', 9960.00),
('d1a3a31c-b631-41ee-a83d-000000000079', 'Provident Fund (PF)', 'DEDUCTION', 7968.00),
('d1a3a31c-b631-41ee-a83d-000000000079', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007a', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000017', 96468.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007a', 'Basic Salary', 'EARNING', 67600.00),
('d1a3a31c-b631-41ee-a83d-00000000007a', 'House Rent Allowance (HRA)', 'EARNING', 27040.00),
('d1a3a31c-b631-41ee-a83d-00000000007a', 'Leave Travel Allowance (LTA)', 'EARNING', 10140.00),
('d1a3a31c-b631-41ee-a83d-00000000007a', 'Provident Fund (PF)', 'DEDUCTION', 8112.00),
('d1a3a31c-b631-41ee-a83d-00000000007a', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007b', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000018', 98184.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007b', 'Basic Salary', 'EARNING', 68800.00),
('d1a3a31c-b631-41ee-a83d-00000000007b', 'House Rent Allowance (HRA)', 'EARNING', 27520.00),
('d1a3a31c-b631-41ee-a83d-00000000007b', 'Leave Travel Allowance (LTA)', 'EARNING', 10320.00),
('d1a3a31c-b631-41ee-a83d-00000000007b', 'Provident Fund (PF)', 'DEDUCTION', 8256.00),
('d1a3a31c-b631-41ee-a83d-00000000007b', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007c', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000019', 99900.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007c', 'Basic Salary', 'EARNING', 70000.00),
('d1a3a31c-b631-41ee-a83d-00000000007c', 'House Rent Allowance (HRA)', 'EARNING', 28000.00),
('d1a3a31c-b631-41ee-a83d-00000000007c', 'Leave Travel Allowance (LTA)', 'EARNING', 10500.00),
('d1a3a31c-b631-41ee-a83d-00000000007c', 'Provident Fund (PF)', 'DEDUCTION', 8400.00),
('d1a3a31c-b631-41ee-a83d-00000000007c', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007d', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001a', 101616.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007d', 'Basic Salary', 'EARNING', 71200.00),
('d1a3a31c-b631-41ee-a83d-00000000007d', 'House Rent Allowance (HRA)', 'EARNING', 28480.00),
('d1a3a31c-b631-41ee-a83d-00000000007d', 'Leave Travel Allowance (LTA)', 'EARNING', 10680.00),
('d1a3a31c-b631-41ee-a83d-00000000007d', 'Provident Fund (PF)', 'DEDUCTION', 8544.00),
('d1a3a31c-b631-41ee-a83d-00000000007d', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007e', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001b', 103332.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007e', 'Basic Salary', 'EARNING', 72400.00),
('d1a3a31c-b631-41ee-a83d-00000000007e', 'House Rent Allowance (HRA)', 'EARNING', 28960.00),
('d1a3a31c-b631-41ee-a83d-00000000007e', 'Leave Travel Allowance (LTA)', 'EARNING', 10860.00),
('d1a3a31c-b631-41ee-a83d-00000000007e', 'Provident Fund (PF)', 'DEDUCTION', 8688.00),
('d1a3a31c-b631-41ee-a83d-00000000007e', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007f', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001c', 105048.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000007f', 'Basic Salary', 'EARNING', 73600.00),
('d1a3a31c-b631-41ee-a83d-00000000007f', 'House Rent Allowance (HRA)', 'EARNING', 29440.00),
('d1a3a31c-b631-41ee-a83d-00000000007f', 'Leave Travel Allowance (LTA)', 'EARNING', 11040.00),
('d1a3a31c-b631-41ee-a83d-00000000007f', 'Provident Fund (PF)', 'DEDUCTION', 8832.00),
('d1a3a31c-b631-41ee-a83d-00000000007f', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000080', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001d', 106764.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000080', 'Basic Salary', 'EARNING', 74800.00),
('d1a3a31c-b631-41ee-a83d-000000000080', 'House Rent Allowance (HRA)', 'EARNING', 29920.00),
('d1a3a31c-b631-41ee-a83d-000000000080', 'Leave Travel Allowance (LTA)', 'EARNING', 11220.00),
('d1a3a31c-b631-41ee-a83d-000000000080', 'Provident Fund (PF)', 'DEDUCTION', 8976.00),
('d1a3a31c-b631-41ee-a83d-000000000080', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000081', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001e', 108480.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000081', 'Basic Salary', 'EARNING', 76000.00),
('d1a3a31c-b631-41ee-a83d-000000000081', 'House Rent Allowance (HRA)', 'EARNING', 30400.00),
('d1a3a31c-b631-41ee-a83d-000000000081', 'Leave Travel Allowance (LTA)', 'EARNING', 11400.00),
('d1a3a31c-b631-41ee-a83d-000000000081', 'Provident Fund (PF)', 'DEDUCTION', 9120.00),
('d1a3a31c-b631-41ee-a83d-000000000081', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000082', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000001f', 110196.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000082', 'Basic Salary', 'EARNING', 77200.00),
('d1a3a31c-b631-41ee-a83d-000000000082', 'House Rent Allowance (HRA)', 'EARNING', 30880.00),
('d1a3a31c-b631-41ee-a83d-000000000082', 'Leave Travel Allowance (LTA)', 'EARNING', 11580.00),
('d1a3a31c-b631-41ee-a83d-000000000082', 'Provident Fund (PF)', 'DEDUCTION', 9264.00),
('d1a3a31c-b631-41ee-a83d-000000000082', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000083', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000020', 111912.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000083', 'Basic Salary', 'EARNING', 78400.00),
('d1a3a31c-b631-41ee-a83d-000000000083', 'House Rent Allowance (HRA)', 'EARNING', 31360.00),
('d1a3a31c-b631-41ee-a83d-000000000083', 'Leave Travel Allowance (LTA)', 'EARNING', 11760.00),
('d1a3a31c-b631-41ee-a83d-000000000083', 'Provident Fund (PF)', 'DEDUCTION', 9408.00),
('d1a3a31c-b631-41ee-a83d-000000000083', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000084', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000021', 113628.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000084', 'Basic Salary', 'EARNING', 79600.00),
('d1a3a31c-b631-41ee-a83d-000000000084', 'House Rent Allowance (HRA)', 'EARNING', 31840.00),
('d1a3a31c-b631-41ee-a83d-000000000084', 'Leave Travel Allowance (LTA)', 'EARNING', 11940.00),
('d1a3a31c-b631-41ee-a83d-000000000084', 'Provident Fund (PF)', 'DEDUCTION', 9552.00),
('d1a3a31c-b631-41ee-a83d-000000000084', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000085', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000022', 115344.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000085', 'Basic Salary', 'EARNING', 80800.00),
('d1a3a31c-b631-41ee-a83d-000000000085', 'House Rent Allowance (HRA)', 'EARNING', 32320.00),
('d1a3a31c-b631-41ee-a83d-000000000085', 'Leave Travel Allowance (LTA)', 'EARNING', 12120.00),
('d1a3a31c-b631-41ee-a83d-000000000085', 'Provident Fund (PF)', 'DEDUCTION', 9696.00),
('d1a3a31c-b631-41ee-a83d-000000000085', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000086', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000023', 117060.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000086', 'Basic Salary', 'EARNING', 82000.00),
('d1a3a31c-b631-41ee-a83d-000000000086', 'House Rent Allowance (HRA)', 'EARNING', 32800.00),
('d1a3a31c-b631-41ee-a83d-000000000086', 'Leave Travel Allowance (LTA)', 'EARNING', 12300.00),
('d1a3a31c-b631-41ee-a83d-000000000086', 'Provident Fund (PF)', 'DEDUCTION', 9840.00),
('d1a3a31c-b631-41ee-a83d-000000000086', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000087', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000024', 118776.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000087', 'Basic Salary', 'EARNING', 83200.00),
('d1a3a31c-b631-41ee-a83d-000000000087', 'House Rent Allowance (HRA)', 'EARNING', 33280.00),
('d1a3a31c-b631-41ee-a83d-000000000087', 'Leave Travel Allowance (LTA)', 'EARNING', 12480.00),
('d1a3a31c-b631-41ee-a83d-000000000087', 'Provident Fund (PF)', 'DEDUCTION', 9984.00),
('d1a3a31c-b631-41ee-a83d-000000000087', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000088', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000025', 120492.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000088', 'Basic Salary', 'EARNING', 84400.00),
('d1a3a31c-b631-41ee-a83d-000000000088', 'House Rent Allowance (HRA)', 'EARNING', 33760.00),
('d1a3a31c-b631-41ee-a83d-000000000088', 'Leave Travel Allowance (LTA)', 'EARNING', 12660.00),
('d1a3a31c-b631-41ee-a83d-000000000088', 'Provident Fund (PF)', 'DEDUCTION', 10128.00),
('d1a3a31c-b631-41ee-a83d-000000000088', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000089', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000026', 122208.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000089', 'Basic Salary', 'EARNING', 85600.00),
('d1a3a31c-b631-41ee-a83d-000000000089', 'House Rent Allowance (HRA)', 'EARNING', 34240.00),
('d1a3a31c-b631-41ee-a83d-000000000089', 'Leave Travel Allowance (LTA)', 'EARNING', 12840.00),
('d1a3a31c-b631-41ee-a83d-000000000089', 'Provident Fund (PF)', 'DEDUCTION', 10272.00),
('d1a3a31c-b631-41ee-a83d-000000000089', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008a', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000027', 123924.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008a', 'Basic Salary', 'EARNING', 86800.00),
('d1a3a31c-b631-41ee-a83d-00000000008a', 'House Rent Allowance (HRA)', 'EARNING', 34720.00),
('d1a3a31c-b631-41ee-a83d-00000000008a', 'Leave Travel Allowance (LTA)', 'EARNING', 13020.00),
('d1a3a31c-b631-41ee-a83d-00000000008a', 'Provident Fund (PF)', 'DEDUCTION', 10416.00),
('d1a3a31c-b631-41ee-a83d-00000000008a', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008b', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000028', 125640.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008b', 'Basic Salary', 'EARNING', 88000.00),
('d1a3a31c-b631-41ee-a83d-00000000008b', 'House Rent Allowance (HRA)', 'EARNING', 35200.00),
('d1a3a31c-b631-41ee-a83d-00000000008b', 'Leave Travel Allowance (LTA)', 'EARNING', 13200.00),
('d1a3a31c-b631-41ee-a83d-00000000008b', 'Provident Fund (PF)', 'DEDUCTION', 10560.00),
('d1a3a31c-b631-41ee-a83d-00000000008b', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008c', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000029', 127356.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008c', 'Basic Salary', 'EARNING', 89200.00),
('d1a3a31c-b631-41ee-a83d-00000000008c', 'House Rent Allowance (HRA)', 'EARNING', 35680.00),
('d1a3a31c-b631-41ee-a83d-00000000008c', 'Leave Travel Allowance (LTA)', 'EARNING', 13380.00),
('d1a3a31c-b631-41ee-a83d-00000000008c', 'Provident Fund (PF)', 'DEDUCTION', 10704.00),
('d1a3a31c-b631-41ee-a83d-00000000008c', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008d', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002a', 129072.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008d', 'Basic Salary', 'EARNING', 90400.00),
('d1a3a31c-b631-41ee-a83d-00000000008d', 'House Rent Allowance (HRA)', 'EARNING', 36160.00),
('d1a3a31c-b631-41ee-a83d-00000000008d', 'Leave Travel Allowance (LTA)', 'EARNING', 13560.00),
('d1a3a31c-b631-41ee-a83d-00000000008d', 'Provident Fund (PF)', 'DEDUCTION', 10848.00),
('d1a3a31c-b631-41ee-a83d-00000000008d', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008e', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002b', 130788.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008e', 'Basic Salary', 'EARNING', 91600.00),
('d1a3a31c-b631-41ee-a83d-00000000008e', 'House Rent Allowance (HRA)', 'EARNING', 36640.00),
('d1a3a31c-b631-41ee-a83d-00000000008e', 'Leave Travel Allowance (LTA)', 'EARNING', 13740.00),
('d1a3a31c-b631-41ee-a83d-00000000008e', 'Provident Fund (PF)', 'DEDUCTION', 10992.00),
('d1a3a31c-b631-41ee-a83d-00000000008e', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008f', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002c', 132504.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000008f', 'Basic Salary', 'EARNING', 92800.00),
('d1a3a31c-b631-41ee-a83d-00000000008f', 'House Rent Allowance (HRA)', 'EARNING', 37120.00),
('d1a3a31c-b631-41ee-a83d-00000000008f', 'Leave Travel Allowance (LTA)', 'EARNING', 13920.00),
('d1a3a31c-b631-41ee-a83d-00000000008f', 'Provident Fund (PF)', 'DEDUCTION', 11136.00),
('d1a3a31c-b631-41ee-a83d-00000000008f', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000090', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002d', 134220.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000090', 'Basic Salary', 'EARNING', 94000.00),
('d1a3a31c-b631-41ee-a83d-000000000090', 'House Rent Allowance (HRA)', 'EARNING', 37600.00),
('d1a3a31c-b631-41ee-a83d-000000000090', 'Leave Travel Allowance (LTA)', 'EARNING', 14100.00),
('d1a3a31c-b631-41ee-a83d-000000000090', 'Provident Fund (PF)', 'DEDUCTION', 11280.00),
('d1a3a31c-b631-41ee-a83d-000000000090', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000091', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002e', 135936.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000091', 'Basic Salary', 'EARNING', 95200.00),
('d1a3a31c-b631-41ee-a83d-000000000091', 'House Rent Allowance (HRA)', 'EARNING', 38080.00),
('d1a3a31c-b631-41ee-a83d-000000000091', 'Leave Travel Allowance (LTA)', 'EARNING', 14280.00),
('d1a3a31c-b631-41ee-a83d-000000000091', 'Provident Fund (PF)', 'DEDUCTION', 11424.00),
('d1a3a31c-b631-41ee-a83d-000000000091', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000092', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000002f', 137652.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000092', 'Basic Salary', 'EARNING', 96400.00),
('d1a3a31c-b631-41ee-a83d-000000000092', 'House Rent Allowance (HRA)', 'EARNING', 38560.00),
('d1a3a31c-b631-41ee-a83d-000000000092', 'Leave Travel Allowance (LTA)', 'EARNING', 14460.00),
('d1a3a31c-b631-41ee-a83d-000000000092', 'Provident Fund (PF)', 'DEDUCTION', 11568.00),
('d1a3a31c-b631-41ee-a83d-000000000092', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000093', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000030', 139368.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000093', 'Basic Salary', 'EARNING', 97600.00),
('d1a3a31c-b631-41ee-a83d-000000000093', 'House Rent Allowance (HRA)', 'EARNING', 39040.00),
('d1a3a31c-b631-41ee-a83d-000000000093', 'Leave Travel Allowance (LTA)', 'EARNING', 14640.00),
('d1a3a31c-b631-41ee-a83d-000000000093', 'Provident Fund (PF)', 'DEDUCTION', 11712.00),
('d1a3a31c-b631-41ee-a83d-000000000093', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000094', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000031', 141084.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000094', 'Basic Salary', 'EARNING', 98800.00),
('d1a3a31c-b631-41ee-a83d-000000000094', 'House Rent Allowance (HRA)', 'EARNING', 39520.00),
('d1a3a31c-b631-41ee-a83d-000000000094', 'Leave Travel Allowance (LTA)', 'EARNING', 14820.00),
('d1a3a31c-b631-41ee-a83d-000000000094', 'Provident Fund (PF)', 'DEDUCTION', 11856.00),
('d1a3a31c-b631-41ee-a83d-000000000094', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000095', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000032', 142800.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000095', 'Basic Salary', 'EARNING', 100000.00),
('d1a3a31c-b631-41ee-a83d-000000000095', 'House Rent Allowance (HRA)', 'EARNING', 40000.00),
('d1a3a31c-b631-41ee-a83d-000000000095', 'Leave Travel Allowance (LTA)', 'EARNING', 15000.00),
('d1a3a31c-b631-41ee-a83d-000000000095', 'Provident Fund (PF)', 'DEDUCTION', 12000.00),
('d1a3a31c-b631-41ee-a83d-000000000095', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000096', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000033', 144516.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000096', 'Basic Salary', 'EARNING', 101200.00),
('d1a3a31c-b631-41ee-a83d-000000000096', 'House Rent Allowance (HRA)', 'EARNING', 40480.00),
('d1a3a31c-b631-41ee-a83d-000000000096', 'Leave Travel Allowance (LTA)', 'EARNING', 15180.00),
('d1a3a31c-b631-41ee-a83d-000000000096', 'Provident Fund (PF)', 'DEDUCTION', 12144.00),
('d1a3a31c-b631-41ee-a83d-000000000096', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000097', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000034', 146232.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000097', 'Basic Salary', 'EARNING', 102400.00),
('d1a3a31c-b631-41ee-a83d-000000000097', 'House Rent Allowance (HRA)', 'EARNING', 40960.00),
('d1a3a31c-b631-41ee-a83d-000000000097', 'Leave Travel Allowance (LTA)', 'EARNING', 15360.00),
('d1a3a31c-b631-41ee-a83d-000000000097', 'Provident Fund (PF)', 'DEDUCTION', 12288.00),
('d1a3a31c-b631-41ee-a83d-000000000097', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000098', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000035', 147948.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000098', 'Basic Salary', 'EARNING', 103600.00),
('d1a3a31c-b631-41ee-a83d-000000000098', 'House Rent Allowance (HRA)', 'EARNING', 41440.00),
('d1a3a31c-b631-41ee-a83d-000000000098', 'Leave Travel Allowance (LTA)', 'EARNING', 15540.00),
('d1a3a31c-b631-41ee-a83d-000000000098', 'Provident Fund (PF)', 'DEDUCTION', 12432.00),
('d1a3a31c-b631-41ee-a83d-000000000098', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000099', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000036', 149664.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000099', 'Basic Salary', 'EARNING', 104800.00),
('d1a3a31c-b631-41ee-a83d-000000000099', 'House Rent Allowance (HRA)', 'EARNING', 41920.00),
('d1a3a31c-b631-41ee-a83d-000000000099', 'Leave Travel Allowance (LTA)', 'EARNING', 15720.00),
('d1a3a31c-b631-41ee-a83d-000000000099', 'Provident Fund (PF)', 'DEDUCTION', 12576.00),
('d1a3a31c-b631-41ee-a83d-000000000099', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009a', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000037', 151380.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009a', 'Basic Salary', 'EARNING', 106000.00),
('d1a3a31c-b631-41ee-a83d-00000000009a', 'House Rent Allowance (HRA)', 'EARNING', 42400.00),
('d1a3a31c-b631-41ee-a83d-00000000009a', 'Leave Travel Allowance (LTA)', 'EARNING', 15900.00),
('d1a3a31c-b631-41ee-a83d-00000000009a', 'Provident Fund (PF)', 'DEDUCTION', 12720.00),
('d1a3a31c-b631-41ee-a83d-00000000009a', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009b', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000038', 153096.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009b', 'Basic Salary', 'EARNING', 107200.00),
('d1a3a31c-b631-41ee-a83d-00000000009b', 'House Rent Allowance (HRA)', 'EARNING', 42880.00),
('d1a3a31c-b631-41ee-a83d-00000000009b', 'Leave Travel Allowance (LTA)', 'EARNING', 16080.00),
('d1a3a31c-b631-41ee-a83d-00000000009b', 'Provident Fund (PF)', 'DEDUCTION', 12864.00),
('d1a3a31c-b631-41ee-a83d-00000000009b', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009c', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000039', 154812.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009c', 'Basic Salary', 'EARNING', 108400.00),
('d1a3a31c-b631-41ee-a83d-00000000009c', 'House Rent Allowance (HRA)', 'EARNING', 43360.00),
('d1a3a31c-b631-41ee-a83d-00000000009c', 'Leave Travel Allowance (LTA)', 'EARNING', 16260.00),
('d1a3a31c-b631-41ee-a83d-00000000009c', 'Provident Fund (PF)', 'DEDUCTION', 13008.00),
('d1a3a31c-b631-41ee-a83d-00000000009c', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009d', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003a', 156528.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009d', 'Basic Salary', 'EARNING', 109600.00),
('d1a3a31c-b631-41ee-a83d-00000000009d', 'House Rent Allowance (HRA)', 'EARNING', 43840.00),
('d1a3a31c-b631-41ee-a83d-00000000009d', 'Leave Travel Allowance (LTA)', 'EARNING', 16440.00),
('d1a3a31c-b631-41ee-a83d-00000000009d', 'Provident Fund (PF)', 'DEDUCTION', 13152.00),
('d1a3a31c-b631-41ee-a83d-00000000009d', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009e', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003b', 158244.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009e', 'Basic Salary', 'EARNING', 110800.00),
('d1a3a31c-b631-41ee-a83d-00000000009e', 'House Rent Allowance (HRA)', 'EARNING', 44320.00),
('d1a3a31c-b631-41ee-a83d-00000000009e', 'Leave Travel Allowance (LTA)', 'EARNING', 16620.00),
('d1a3a31c-b631-41ee-a83d-00000000009e', 'Provident Fund (PF)', 'DEDUCTION', 13296.00),
('d1a3a31c-b631-41ee-a83d-00000000009e', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009f', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003c', 159960.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-00000000009f', 'Basic Salary', 'EARNING', 112000.00),
('d1a3a31c-b631-41ee-a83d-00000000009f', 'House Rent Allowance (HRA)', 'EARNING', 44800.00),
('d1a3a31c-b631-41ee-a83d-00000000009f', 'Leave Travel Allowance (LTA)', 'EARNING', 16800.00),
('d1a3a31c-b631-41ee-a83d-00000000009f', 'Provident Fund (PF)', 'DEDUCTION', 13440.00),
('d1a3a31c-b631-41ee-a83d-00000000009f', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003d', 161676.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'Basic Salary', 'EARNING', 113200.00),
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'House Rent Allowance (HRA)', 'EARNING', 45280.00),
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'Leave Travel Allowance (LTA)', 'EARNING', 16980.00),
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'Provident Fund (PF)', 'DEDUCTION', 13584.00),
('d1a3a31c-b631-41ee-a83d-0000000000a0', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003e', 163392.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'Basic Salary', 'EARNING', 114400.00),
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'House Rent Allowance (HRA)', 'EARNING', 45760.00),
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'Leave Travel Allowance (LTA)', 'EARNING', 17160.00),
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'Provident Fund (PF)', 'DEDUCTION', 13728.00),
('d1a3a31c-b631-41ee-a83d-0000000000a1', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-00000000003f', 165108.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'Basic Salary', 'EARNING', 115600.00),
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'House Rent Allowance (HRA)', 'EARNING', 46240.00),
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'Leave Travel Allowance (LTA)', 'EARNING', 17340.00),
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'Provident Fund (PF)', 'DEDUCTION', 13872.00),
('d1a3a31c-b631-41ee-a83d-0000000000a2', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000040', 166824.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'Basic Salary', 'EARNING', 116800.00),
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'House Rent Allowance (HRA)', 'EARNING', 46720.00),
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'Leave Travel Allowance (LTA)', 'EARNING', 17520.00),
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'Provident Fund (PF)', 'DEDUCTION', 14016.00),
('d1a3a31c-b631-41ee-a83d-0000000000a3', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f01', 'e4a6a31c-b631-41ee-a83d-000000000041', 168540.00, '2026-05-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'Basic Salary', 'EARNING', 118000.00),
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'House Rent Allowance (HRA)', 'EARNING', 47200.00),
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'Leave Travel Allowance (LTA)', 'EARNING', 17700.00),
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'Provident Fund (PF)', 'DEDUCTION', 14160.00),
('d1a3a31c-b631-41ee-a83d-0000000000a4', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_runs (id, billing_month, status, total_payout, created_at, updated_at) VALUES
('d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'June 2026', 'PROCESSED', 7385820.00, '2026-06-30 18:00:00+00', '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000001', 58716.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'Basic Salary', 'EARNING', 41200.00),
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'House Rent Allowance (HRA)', 'EARNING', 16480.00),
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'Leave Travel Allowance (LTA)', 'EARNING', 6180.00),
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'Provident Fund (PF)', 'DEDUCTION', 4944.00),
('d1a3a31c-b631-41ee-a83d-0000000000c8', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000002', 60432.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'Basic Salary', 'EARNING', 42400.00),
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'House Rent Allowance (HRA)', 'EARNING', 16960.00),
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'Leave Travel Allowance (LTA)', 'EARNING', 6360.00),
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'Provident Fund (PF)', 'DEDUCTION', 5088.00),
('d1a3a31c-b631-41ee-a83d-0000000000c9', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000003', 62148.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'Basic Salary', 'EARNING', 43600.00),
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'House Rent Allowance (HRA)', 'EARNING', 17440.00),
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'Leave Travel Allowance (LTA)', 'EARNING', 6540.00),
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'Provident Fund (PF)', 'DEDUCTION', 5232.00),
('d1a3a31c-b631-41ee-a83d-0000000000ca', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000004', 63864.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'Basic Salary', 'EARNING', 44800.00),
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'House Rent Allowance (HRA)', 'EARNING', 17920.00),
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'Leave Travel Allowance (LTA)', 'EARNING', 6720.00),
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'Provident Fund (PF)', 'DEDUCTION', 5376.00),
('d1a3a31c-b631-41ee-a83d-0000000000cb', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000005', 65580.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'Basic Salary', 'EARNING', 46000.00),
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'House Rent Allowance (HRA)', 'EARNING', 18400.00),
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'Leave Travel Allowance (LTA)', 'EARNING', 6900.00),
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'Provident Fund (PF)', 'DEDUCTION', 5520.00),
('d1a3a31c-b631-41ee-a83d-0000000000cc', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000006', 67296.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'Basic Salary', 'EARNING', 47200.00),
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'House Rent Allowance (HRA)', 'EARNING', 18880.00),
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'Leave Travel Allowance (LTA)', 'EARNING', 7080.00),
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'Provident Fund (PF)', 'DEDUCTION', 5664.00),
('d1a3a31c-b631-41ee-a83d-0000000000cd', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000007', 69012.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'Basic Salary', 'EARNING', 48400.00),
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'House Rent Allowance (HRA)', 'EARNING', 19360.00),
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'Leave Travel Allowance (LTA)', 'EARNING', 7260.00),
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'Provident Fund (PF)', 'DEDUCTION', 5808.00),
('d1a3a31c-b631-41ee-a83d-0000000000ce', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000008', 70728.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'Basic Salary', 'EARNING', 49600.00),
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'House Rent Allowance (HRA)', 'EARNING', 19840.00),
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'Leave Travel Allowance (LTA)', 'EARNING', 7440.00),
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'Provident Fund (PF)', 'DEDUCTION', 5952.00),
('d1a3a31c-b631-41ee-a83d-0000000000cf', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000009', 72444.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'Basic Salary', 'EARNING', 50800.00),
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'House Rent Allowance (HRA)', 'EARNING', 20320.00),
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'Leave Travel Allowance (LTA)', 'EARNING', 7620.00),
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'Provident Fund (PF)', 'DEDUCTION', 6096.00),
('d1a3a31c-b631-41ee-a83d-0000000000d0', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000a', 74160.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'Basic Salary', 'EARNING', 52000.00),
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'House Rent Allowance (HRA)', 'EARNING', 20800.00),
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'Leave Travel Allowance (LTA)', 'EARNING', 7800.00),
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'Provident Fund (PF)', 'DEDUCTION', 6240.00),
('d1a3a31c-b631-41ee-a83d-0000000000d1', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000b', 75876.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'Basic Salary', 'EARNING', 53200.00),
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'House Rent Allowance (HRA)', 'EARNING', 21280.00),
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'Leave Travel Allowance (LTA)', 'EARNING', 7980.00),
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'Provident Fund (PF)', 'DEDUCTION', 6384.00),
('d1a3a31c-b631-41ee-a83d-0000000000d2', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000c', 77592.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'Basic Salary', 'EARNING', 54400.00),
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'House Rent Allowance (HRA)', 'EARNING', 21760.00),
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'Leave Travel Allowance (LTA)', 'EARNING', 8160.00),
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'Provident Fund (PF)', 'DEDUCTION', 6528.00),
('d1a3a31c-b631-41ee-a83d-0000000000d3', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000d', 79308.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'Basic Salary', 'EARNING', 55600.00),
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'House Rent Allowance (HRA)', 'EARNING', 22240.00),
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'Leave Travel Allowance (LTA)', 'EARNING', 8340.00),
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'Provident Fund (PF)', 'DEDUCTION', 6672.00),
('d1a3a31c-b631-41ee-a83d-0000000000d4', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000e', 81024.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'Basic Salary', 'EARNING', 56800.00),
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'House Rent Allowance (HRA)', 'EARNING', 22720.00),
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'Leave Travel Allowance (LTA)', 'EARNING', 8520.00),
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'Provident Fund (PF)', 'DEDUCTION', 6816.00),
('d1a3a31c-b631-41ee-a83d-0000000000d5', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000000f', 82740.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'Basic Salary', 'EARNING', 58000.00),
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'House Rent Allowance (HRA)', 'EARNING', 23200.00),
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'Leave Travel Allowance (LTA)', 'EARNING', 8700.00),
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'Provident Fund (PF)', 'DEDUCTION', 6960.00),
('d1a3a31c-b631-41ee-a83d-0000000000d6', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000010', 84456.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'Basic Salary', 'EARNING', 59200.00),
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'House Rent Allowance (HRA)', 'EARNING', 23680.00),
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'Leave Travel Allowance (LTA)', 'EARNING', 8880.00),
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'Provident Fund (PF)', 'DEDUCTION', 7104.00),
('d1a3a31c-b631-41ee-a83d-0000000000d7', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000011', 86172.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'Basic Salary', 'EARNING', 60400.00),
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'House Rent Allowance (HRA)', 'EARNING', 24160.00),
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'Leave Travel Allowance (LTA)', 'EARNING', 9060.00),
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'Provident Fund (PF)', 'DEDUCTION', 7248.00),
('d1a3a31c-b631-41ee-a83d-0000000000d8', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000012', 87888.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'Basic Salary', 'EARNING', 61600.00),
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'House Rent Allowance (HRA)', 'EARNING', 24640.00),
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'Leave Travel Allowance (LTA)', 'EARNING', 9240.00),
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'Provident Fund (PF)', 'DEDUCTION', 7392.00),
('d1a3a31c-b631-41ee-a83d-0000000000d9', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000da', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000013', 89604.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000da', 'Basic Salary', 'EARNING', 62800.00),
('d1a3a31c-b631-41ee-a83d-0000000000da', 'House Rent Allowance (HRA)', 'EARNING', 25120.00),
('d1a3a31c-b631-41ee-a83d-0000000000da', 'Leave Travel Allowance (LTA)', 'EARNING', 9420.00),
('d1a3a31c-b631-41ee-a83d-0000000000da', 'Provident Fund (PF)', 'DEDUCTION', 7536.00),
('d1a3a31c-b631-41ee-a83d-0000000000da', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000db', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000014', 91320.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000db', 'Basic Salary', 'EARNING', 64000.00),
('d1a3a31c-b631-41ee-a83d-0000000000db', 'House Rent Allowance (HRA)', 'EARNING', 25600.00),
('d1a3a31c-b631-41ee-a83d-0000000000db', 'Leave Travel Allowance (LTA)', 'EARNING', 9600.00),
('d1a3a31c-b631-41ee-a83d-0000000000db', 'Provident Fund (PF)', 'DEDUCTION', 7680.00),
('d1a3a31c-b631-41ee-a83d-0000000000db', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000015', 93036.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'Basic Salary', 'EARNING', 65200.00),
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'House Rent Allowance (HRA)', 'EARNING', 26080.00),
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'Leave Travel Allowance (LTA)', 'EARNING', 9780.00),
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'Provident Fund (PF)', 'DEDUCTION', 7824.00),
('d1a3a31c-b631-41ee-a83d-0000000000dc', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000016', 94752.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'Basic Salary', 'EARNING', 66400.00),
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'House Rent Allowance (HRA)', 'EARNING', 26560.00),
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'Leave Travel Allowance (LTA)', 'EARNING', 9960.00),
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'Provident Fund (PF)', 'DEDUCTION', 7968.00),
('d1a3a31c-b631-41ee-a83d-0000000000dd', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000de', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000017', 96468.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000de', 'Basic Salary', 'EARNING', 67600.00),
('d1a3a31c-b631-41ee-a83d-0000000000de', 'House Rent Allowance (HRA)', 'EARNING', 27040.00),
('d1a3a31c-b631-41ee-a83d-0000000000de', 'Leave Travel Allowance (LTA)', 'EARNING', 10140.00),
('d1a3a31c-b631-41ee-a83d-0000000000de', 'Provident Fund (PF)', 'DEDUCTION', 8112.00),
('d1a3a31c-b631-41ee-a83d-0000000000de', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000df', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000018', 98184.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000df', 'Basic Salary', 'EARNING', 68800.00),
('d1a3a31c-b631-41ee-a83d-0000000000df', 'House Rent Allowance (HRA)', 'EARNING', 27520.00),
('d1a3a31c-b631-41ee-a83d-0000000000df', 'Leave Travel Allowance (LTA)', 'EARNING', 10320.00),
('d1a3a31c-b631-41ee-a83d-0000000000df', 'Provident Fund (PF)', 'DEDUCTION', 8256.00),
('d1a3a31c-b631-41ee-a83d-0000000000df', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000019', 99900.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'Basic Salary', 'EARNING', 70000.00),
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'House Rent Allowance (HRA)', 'EARNING', 28000.00),
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'Leave Travel Allowance (LTA)', 'EARNING', 10500.00),
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'Provident Fund (PF)', 'DEDUCTION', 8400.00),
('d1a3a31c-b631-41ee-a83d-0000000000e0', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001a', 101616.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'Basic Salary', 'EARNING', 71200.00),
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'House Rent Allowance (HRA)', 'EARNING', 28480.00),
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'Leave Travel Allowance (LTA)', 'EARNING', 10680.00),
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'Provident Fund (PF)', 'DEDUCTION', 8544.00),
('d1a3a31c-b631-41ee-a83d-0000000000e1', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001b', 103332.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'Basic Salary', 'EARNING', 72400.00),
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'House Rent Allowance (HRA)', 'EARNING', 28960.00),
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'Leave Travel Allowance (LTA)', 'EARNING', 10860.00),
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'Provident Fund (PF)', 'DEDUCTION', 8688.00),
('d1a3a31c-b631-41ee-a83d-0000000000e2', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001c', 105048.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'Basic Salary', 'EARNING', 73600.00),
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'House Rent Allowance (HRA)', 'EARNING', 29440.00),
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'Leave Travel Allowance (LTA)', 'EARNING', 11040.00),
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'Provident Fund (PF)', 'DEDUCTION', 8832.00),
('d1a3a31c-b631-41ee-a83d-0000000000e3', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001d', 106764.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'Basic Salary', 'EARNING', 74800.00),
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'House Rent Allowance (HRA)', 'EARNING', 29920.00),
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'Leave Travel Allowance (LTA)', 'EARNING', 11220.00),
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'Provident Fund (PF)', 'DEDUCTION', 8976.00),
('d1a3a31c-b631-41ee-a83d-0000000000e4', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001e', 108480.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'Basic Salary', 'EARNING', 76000.00),
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'House Rent Allowance (HRA)', 'EARNING', 30400.00),
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'Leave Travel Allowance (LTA)', 'EARNING', 11400.00),
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'Provident Fund (PF)', 'DEDUCTION', 9120.00),
('d1a3a31c-b631-41ee-a83d-0000000000e5', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000001f', 110196.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'Basic Salary', 'EARNING', 77200.00),
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'House Rent Allowance (HRA)', 'EARNING', 30880.00),
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'Leave Travel Allowance (LTA)', 'EARNING', 11580.00),
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'Provident Fund (PF)', 'DEDUCTION', 9264.00),
('d1a3a31c-b631-41ee-a83d-0000000000e6', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000020', 111912.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'Basic Salary', 'EARNING', 78400.00),
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'House Rent Allowance (HRA)', 'EARNING', 31360.00),
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'Leave Travel Allowance (LTA)', 'EARNING', 11760.00),
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'Provident Fund (PF)', 'DEDUCTION', 9408.00),
('d1a3a31c-b631-41ee-a83d-0000000000e7', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000021', 113628.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'Basic Salary', 'EARNING', 79600.00),
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'House Rent Allowance (HRA)', 'EARNING', 31840.00),
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'Leave Travel Allowance (LTA)', 'EARNING', 11940.00),
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'Provident Fund (PF)', 'DEDUCTION', 9552.00),
('d1a3a31c-b631-41ee-a83d-0000000000e8', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000022', 115344.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'Basic Salary', 'EARNING', 80800.00),
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'House Rent Allowance (HRA)', 'EARNING', 32320.00),
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'Leave Travel Allowance (LTA)', 'EARNING', 12120.00),
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'Provident Fund (PF)', 'DEDUCTION', 9696.00),
('d1a3a31c-b631-41ee-a83d-0000000000e9', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000023', 117060.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'Basic Salary', 'EARNING', 82000.00),
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'House Rent Allowance (HRA)', 'EARNING', 32800.00),
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'Leave Travel Allowance (LTA)', 'EARNING', 12300.00),
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'Provident Fund (PF)', 'DEDUCTION', 9840.00),
('d1a3a31c-b631-41ee-a83d-0000000000ea', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000024', 118776.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'Basic Salary', 'EARNING', 83200.00),
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'House Rent Allowance (HRA)', 'EARNING', 33280.00),
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'Leave Travel Allowance (LTA)', 'EARNING', 12480.00),
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'Provident Fund (PF)', 'DEDUCTION', 9984.00),
('d1a3a31c-b631-41ee-a83d-0000000000eb', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000025', 120492.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'Basic Salary', 'EARNING', 84400.00),
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'House Rent Allowance (HRA)', 'EARNING', 33760.00),
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'Leave Travel Allowance (LTA)', 'EARNING', 12660.00),
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'Provident Fund (PF)', 'DEDUCTION', 10128.00),
('d1a3a31c-b631-41ee-a83d-0000000000ec', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000026', 122208.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'Basic Salary', 'EARNING', 85600.00),
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'House Rent Allowance (HRA)', 'EARNING', 34240.00),
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'Leave Travel Allowance (LTA)', 'EARNING', 12840.00),
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'Provident Fund (PF)', 'DEDUCTION', 10272.00),
('d1a3a31c-b631-41ee-a83d-0000000000ed', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000027', 123924.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'Basic Salary', 'EARNING', 86800.00),
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'House Rent Allowance (HRA)', 'EARNING', 34720.00),
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'Leave Travel Allowance (LTA)', 'EARNING', 13020.00),
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'Provident Fund (PF)', 'DEDUCTION', 10416.00),
('d1a3a31c-b631-41ee-a83d-0000000000ee', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000028', 125640.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'Basic Salary', 'EARNING', 88000.00),
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'House Rent Allowance (HRA)', 'EARNING', 35200.00),
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'Leave Travel Allowance (LTA)', 'EARNING', 13200.00),
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'Provident Fund (PF)', 'DEDUCTION', 10560.00),
('d1a3a31c-b631-41ee-a83d-0000000000ef', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000029', 127356.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'Basic Salary', 'EARNING', 89200.00),
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'House Rent Allowance (HRA)', 'EARNING', 35680.00),
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'Leave Travel Allowance (LTA)', 'EARNING', 13380.00),
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'Provident Fund (PF)', 'DEDUCTION', 10704.00),
('d1a3a31c-b631-41ee-a83d-0000000000f0', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002a', 129072.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'Basic Salary', 'EARNING', 90400.00),
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'House Rent Allowance (HRA)', 'EARNING', 36160.00),
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'Leave Travel Allowance (LTA)', 'EARNING', 13560.00),
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'Provident Fund (PF)', 'DEDUCTION', 10848.00),
('d1a3a31c-b631-41ee-a83d-0000000000f1', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002b', 130788.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'Basic Salary', 'EARNING', 91600.00),
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'House Rent Allowance (HRA)', 'EARNING', 36640.00),
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'Leave Travel Allowance (LTA)', 'EARNING', 13740.00),
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'Provident Fund (PF)', 'DEDUCTION', 10992.00),
('d1a3a31c-b631-41ee-a83d-0000000000f2', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002c', 132504.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'Basic Salary', 'EARNING', 92800.00),
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'House Rent Allowance (HRA)', 'EARNING', 37120.00),
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'Leave Travel Allowance (LTA)', 'EARNING', 13920.00),
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'Provident Fund (PF)', 'DEDUCTION', 11136.00),
('d1a3a31c-b631-41ee-a83d-0000000000f3', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002d', 134220.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'Basic Salary', 'EARNING', 94000.00),
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'House Rent Allowance (HRA)', 'EARNING', 37600.00),
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'Leave Travel Allowance (LTA)', 'EARNING', 14100.00),
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'Provident Fund (PF)', 'DEDUCTION', 11280.00),
('d1a3a31c-b631-41ee-a83d-0000000000f4', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002e', 135936.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'Basic Salary', 'EARNING', 95200.00),
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'House Rent Allowance (HRA)', 'EARNING', 38080.00),
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'Leave Travel Allowance (LTA)', 'EARNING', 14280.00),
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'Provident Fund (PF)', 'DEDUCTION', 11424.00),
('d1a3a31c-b631-41ee-a83d-0000000000f5', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000002f', 137652.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'Basic Salary', 'EARNING', 96400.00),
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'House Rent Allowance (HRA)', 'EARNING', 38560.00),
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'Leave Travel Allowance (LTA)', 'EARNING', 14460.00),
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'Provident Fund (PF)', 'DEDUCTION', 11568.00),
('d1a3a31c-b631-41ee-a83d-0000000000f6', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000030', 139368.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'Basic Salary', 'EARNING', 97600.00),
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'House Rent Allowance (HRA)', 'EARNING', 39040.00),
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'Leave Travel Allowance (LTA)', 'EARNING', 14640.00),
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'Provident Fund (PF)', 'DEDUCTION', 11712.00),
('d1a3a31c-b631-41ee-a83d-0000000000f7', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000031', 141084.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'Basic Salary', 'EARNING', 98800.00),
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'House Rent Allowance (HRA)', 'EARNING', 39520.00),
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'Leave Travel Allowance (LTA)', 'EARNING', 14820.00),
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'Provident Fund (PF)', 'DEDUCTION', 11856.00),
('d1a3a31c-b631-41ee-a83d-0000000000f8', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000032', 142800.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'Basic Salary', 'EARNING', 100000.00),
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'House Rent Allowance (HRA)', 'EARNING', 40000.00),
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'Leave Travel Allowance (LTA)', 'EARNING', 15000.00),
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'Provident Fund (PF)', 'DEDUCTION', 12000.00),
('d1a3a31c-b631-41ee-a83d-0000000000f9', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000033', 144516.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'Basic Salary', 'EARNING', 101200.00),
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'House Rent Allowance (HRA)', 'EARNING', 40480.00),
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'Leave Travel Allowance (LTA)', 'EARNING', 15180.00),
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'Provident Fund (PF)', 'DEDUCTION', 12144.00),
('d1a3a31c-b631-41ee-a83d-0000000000fa', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000034', 146232.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'Basic Salary', 'EARNING', 102400.00),
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'House Rent Allowance (HRA)', 'EARNING', 40960.00),
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'Leave Travel Allowance (LTA)', 'EARNING', 15360.00),
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'Provident Fund (PF)', 'DEDUCTION', 12288.00),
('d1a3a31c-b631-41ee-a83d-0000000000fb', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000035', 147948.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'Basic Salary', 'EARNING', 103600.00),
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'House Rent Allowance (HRA)', 'EARNING', 41440.00),
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'Leave Travel Allowance (LTA)', 'EARNING', 15540.00),
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'Provident Fund (PF)', 'DEDUCTION', 12432.00),
('d1a3a31c-b631-41ee-a83d-0000000000fc', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000036', 149664.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'Basic Salary', 'EARNING', 104800.00),
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'House Rent Allowance (HRA)', 'EARNING', 41920.00),
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'Leave Travel Allowance (LTA)', 'EARNING', 15720.00),
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'Provident Fund (PF)', 'DEDUCTION', 12576.00),
('d1a3a31c-b631-41ee-a83d-0000000000fd', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000037', 151380.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'Basic Salary', 'EARNING', 106000.00),
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'House Rent Allowance (HRA)', 'EARNING', 42400.00),
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'Leave Travel Allowance (LTA)', 'EARNING', 15900.00),
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'Provident Fund (PF)', 'DEDUCTION', 12720.00),
('d1a3a31c-b631-41ee-a83d-0000000000fe', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000038', 153096.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'Basic Salary', 'EARNING', 107200.00),
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'House Rent Allowance (HRA)', 'EARNING', 42880.00),
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'Leave Travel Allowance (LTA)', 'EARNING', 16080.00),
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'Provident Fund (PF)', 'DEDUCTION', 12864.00),
('d1a3a31c-b631-41ee-a83d-0000000000ff', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000100', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000039', 154812.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000100', 'Basic Salary', 'EARNING', 108400.00),
('d1a3a31c-b631-41ee-a83d-000000000100', 'House Rent Allowance (HRA)', 'EARNING', 43360.00),
('d1a3a31c-b631-41ee-a83d-000000000100', 'Leave Travel Allowance (LTA)', 'EARNING', 16260.00),
('d1a3a31c-b631-41ee-a83d-000000000100', 'Provident Fund (PF)', 'DEDUCTION', 13008.00),
('d1a3a31c-b631-41ee-a83d-000000000100', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000101', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003a', 156528.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000101', 'Basic Salary', 'EARNING', 109600.00),
('d1a3a31c-b631-41ee-a83d-000000000101', 'House Rent Allowance (HRA)', 'EARNING', 43840.00),
('d1a3a31c-b631-41ee-a83d-000000000101', 'Leave Travel Allowance (LTA)', 'EARNING', 16440.00),
('d1a3a31c-b631-41ee-a83d-000000000101', 'Provident Fund (PF)', 'DEDUCTION', 13152.00),
('d1a3a31c-b631-41ee-a83d-000000000101', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000102', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003b', 158244.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000102', 'Basic Salary', 'EARNING', 110800.00),
('d1a3a31c-b631-41ee-a83d-000000000102', 'House Rent Allowance (HRA)', 'EARNING', 44320.00),
('d1a3a31c-b631-41ee-a83d-000000000102', 'Leave Travel Allowance (LTA)', 'EARNING', 16620.00),
('d1a3a31c-b631-41ee-a83d-000000000102', 'Provident Fund (PF)', 'DEDUCTION', 13296.00),
('d1a3a31c-b631-41ee-a83d-000000000102', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000103', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003c', 159960.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000103', 'Basic Salary', 'EARNING', 112000.00),
('d1a3a31c-b631-41ee-a83d-000000000103', 'House Rent Allowance (HRA)', 'EARNING', 44800.00),
('d1a3a31c-b631-41ee-a83d-000000000103', 'Leave Travel Allowance (LTA)', 'EARNING', 16800.00),
('d1a3a31c-b631-41ee-a83d-000000000103', 'Provident Fund (PF)', 'DEDUCTION', 13440.00),
('d1a3a31c-b631-41ee-a83d-000000000103', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000104', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003d', 161676.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000104', 'Basic Salary', 'EARNING', 113200.00),
('d1a3a31c-b631-41ee-a83d-000000000104', 'House Rent Allowance (HRA)', 'EARNING', 45280.00),
('d1a3a31c-b631-41ee-a83d-000000000104', 'Leave Travel Allowance (LTA)', 'EARNING', 16980.00),
('d1a3a31c-b631-41ee-a83d-000000000104', 'Provident Fund (PF)', 'DEDUCTION', 13584.00),
('d1a3a31c-b631-41ee-a83d-000000000104', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000105', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003e', 163392.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000105', 'Basic Salary', 'EARNING', 114400.00),
('d1a3a31c-b631-41ee-a83d-000000000105', 'House Rent Allowance (HRA)', 'EARNING', 45760.00),
('d1a3a31c-b631-41ee-a83d-000000000105', 'Leave Travel Allowance (LTA)', 'EARNING', 17160.00),
('d1a3a31c-b631-41ee-a83d-000000000105', 'Provident Fund (PF)', 'DEDUCTION', 13728.00),
('d1a3a31c-b631-41ee-a83d-000000000105', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000106', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-00000000003f', 165108.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000106', 'Basic Salary', 'EARNING', 115600.00),
('d1a3a31c-b631-41ee-a83d-000000000106', 'House Rent Allowance (HRA)', 'EARNING', 46240.00),
('d1a3a31c-b631-41ee-a83d-000000000106', 'Leave Travel Allowance (LTA)', 'EARNING', 17340.00),
('d1a3a31c-b631-41ee-a83d-000000000106', 'Provident Fund (PF)', 'DEDUCTION', 13872.00),
('d1a3a31c-b631-41ee-a83d-000000000106', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000107', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000040', 166824.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000107', 'Basic Salary', 'EARNING', 116800.00),
('d1a3a31c-b631-41ee-a83d-000000000107', 'House Rent Allowance (HRA)', 'EARNING', 46720.00),
('d1a3a31c-b631-41ee-a83d-000000000107', 'Leave Travel Allowance (LTA)', 'EARNING', 17520.00),
('d1a3a31c-b631-41ee-a83d-000000000107', 'Provident Fund (PF)', 'DEDUCTION', 14016.00),
('d1a3a31c-b631-41ee-a83d-000000000107', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payslips (id, payroll_run_id, employee_id, net_pay, created_at) VALUES
('d1a3a31c-b631-41ee-a83d-000000000108', 'd9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f02', 'e4a6a31c-b631-41ee-a83d-000000000041', 168540.00, '2026-06-30 18:00:00+00') ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_components (payslip_id, name, type, amount) VALUES
('d1a3a31c-b631-41ee-a83d-000000000108', 'Basic Salary', 'EARNING', 118000.00),
('d1a3a31c-b631-41ee-a83d-000000000108', 'House Rent Allowance (HRA)', 'EARNING', 47200.00),
('d1a3a31c-b631-41ee-a83d-000000000108', 'Leave Travel Allowance (LTA)', 'EARNING', 17700.00),
('d1a3a31c-b631-41ee-a83d-000000000108', 'Provident Fund (PF)', 'DEDUCTION', 14160.00),
('d1a3a31c-b631-41ee-a83d-000000000108', 'Professional Tax', 'DEDUCTION', 200.00)
ON CONFLICT (id) DO NOTHING;

INSERT INTO payroll_runs (id, billing_month, status, total_payout, created_at, updated_at) VALUES
('d9e8f7a6-b5c4-3d2e-1f0a-9b8c7d6e5f03', 'July 2026 (Draft)', 'PENDING', 0.00, '2026-07-06 12:00:00+00', '2026-07-06 12:00:00+00') ON CONFLICT (id) DO NOTHING;