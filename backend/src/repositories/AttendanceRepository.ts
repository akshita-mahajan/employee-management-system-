import { BaseRepository } from "./BaseRepository.js";
import pool from "../config/database.js";
import { buildPaginationQuery, PaginationOptions, PaginationResult } from "../utils/pagination.js";

export interface Attendance {
  id: string;
  employee_id: string;
  date: string;
  status: string;
  created_at: Date;
  updated_at: Date;
  deleted_at: Date | null;
}

export class AttendanceRepository extends BaseRepository<Attendance> {
  constructor() {
    super("attendance");
  }

  async findPaginated(options: PaginationOptions): Promise<PaginationResult<Attendance>> {
    const baseQuery = "SELECT id, employee_id, date, status, deleted_at FROM attendance";
    const searchableFields = ["status"];
    
    const { countQuery, dataQuery, params, page, limit } = buildPaginationQuery(
      baseQuery,
      options,
      searchableFields,
      { date: "date", employeeId: "employee_id" }
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

  async recordCheckIn(employeeId: string, date: string, status: string = "PRESENT"): Promise<Attendance> {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");
      
      const attRes = await client.query(
        `INSERT INTO attendance (employee_id, date, status) 
         VALUES ($1, $2, $3) 
         ON CONFLICT (employee_id, date) DO UPDATE SET status = EXCLUDED.status, updated_at = CURRENT_TIMESTAMP
         RETURNING *`,
        [employeeId, date, status]
      );
      
      const attendanceId = attRes.rows[0].id;
      
      await client.query(
        `INSERT INTO attendance_logs (attendance_id, check_in) 
         VALUES ($1, CURRENT_TIMESTAMP)`,
        [attendanceId]
      );

      await client.query("COMMIT");
      return attRes.rows[0];
    } catch (e) {
      await client.query("ROLLBACK");
      throw e;
    } finally {
      client.release();
    }
  }
}
