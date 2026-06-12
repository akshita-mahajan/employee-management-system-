import { BaseRepository } from "./BaseRepository.js";
import pool from "../config/database.js";
import { buildPaginationQuery, PaginationOptions, PaginationResult } from "../utils/pagination.js";

export interface Employee {
  id: string;
  user_id: string | null;
  employee_id: string;
  first_name: string;
  last_name: string;
  email: string;
  phone: string | null;
  department_id: string | null;
  designation: string;
  joining_date: Date;
  status: string;
  reporting_manager_id: string | null;
  created_at: Date;
  updated_at: Date;
  deleted_at: Date | null;
}

export class EmployeeRepository extends BaseRepository<Employee> {
  constructor() {
    super("employees");
  }

  async findByEmail(email: string): Promise<Employee | null> {
    const res = await pool.query(
      "SELECT * FROM employees WHERE email = $1 AND deleted_at IS NULL",
      [email]
    );
    return res.rows[0] || null;
  }

  async findPaginated(options: PaginationOptions): Promise<PaginationResult<Employee>> {
    const baseQuery = "SELECT id, employee_id, first_name, last_name, email, phone, designation, status, department_id, joining_date, deleted_at FROM employees";
    const searchableFields = ["first_name", "last_name", "email", "employee_id", "designation"];
    
    const { countQuery, dataQuery, params, page, limit } = buildPaginationQuery(
      baseQuery,
      options,
      searchableFields,
      { departmentId: "department_id", status: "status" }
    );

    const countRes = await pool.query(countQuery, params.slice(0, params.length - 2));
    const dataRes = await pool.query(dataQuery, params);

    const total = countRes.rows[0]?.total || 0;

    return {
      data: dataRes.rows,
      metadata: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async insert(employee: Omit<Employee, "id" | "created_at" | "updated_at" | "deleted_at">): Promise<Employee> {
    const queryStr = `
      INSERT INTO employees (
        user_id, employee_id, first_name, last_name, email, phone, 
        department_id, designation, joining_date, status, reporting_manager_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
      RETURNING *
    `;
    const values = [
      employee.user_id, employee.employee_id, employee.first_name, employee.last_name,
      employee.email, employee.phone, employee.department_id, employee.designation,
      employee.joining_date, employee.status, employee.reporting_manager_id
    ];
    const res = await pool.query(queryStr, values);
    return res.rows[0];
  }

  async update(id: string, employee: Partial<Omit<Employee, "id" | "created_at" | "updated_at" | "deleted_at">>): Promise<Employee | null> {
    const setClauses: string[] = [];
    const values: any[] = [];
    let paramIndex = 1;

    for (const [key, val] of Object.entries(employee)) {
      setClauses.push(`${key} = $${paramIndex}`);
      values.push(val);
      paramIndex++;
    }

    if (setClauses.length === 0) return this.findById(id);

    values.push(id);
    const queryStr = `
      UPDATE employees 
      SET ${setClauses.join(", ")}, updated_at = CURRENT_TIMESTAMP
      WHERE id = $${paramIndex} AND deleted_at IS NULL
      RETURNING *
    `;

    const res = await pool.query(queryStr, values);
    return res.rows[0] || null;
  }

  async restore(id: string): Promise<boolean> {
    const res = await pool.query(
      "UPDATE employees SET deleted_at = NULL, updated_at = CURRENT_TIMESTAMP WHERE id = $1 AND deleted_at IS NOT NULL",
      [id]
    );
    return (res.rowCount ?? 0) > 0;
  }
}
