import pool from "../config/database.js";

export class BaseRepository<T> {
  protected tableName: string;

  constructor(tableName: string) {
    this.tableName = tableName;
  }

  async findById(id: string): Promise<T | null> {
    const res = await pool.query(
      `SELECT * FROM ${this.tableName} WHERE id = $1 AND deleted_at IS NULL`,
      [id]
    );
    return res.rows[0] || null;
  }

  async deleteSoft(id: string, updatedBy?: string): Promise<boolean> {
    const res = await pool.query(
      `UPDATE ${this.tableName} SET deleted_at = CURRENT_TIMESTAMP, updated_by = $1 WHERE id = $2 AND deleted_at IS NULL`,
      [updatedBy || null, id]
    );
    return (res.rowCount ?? 0) > 0;
  }

  async deleteHard(id: string): Promise<boolean> {
    const res = await pool.query(`DELETE FROM ${this.tableName} WHERE id = $1`, [id]);
    return (res.rowCount ?? 0) > 0;
  }
}
