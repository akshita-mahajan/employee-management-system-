import { BaseRepository } from "./BaseRepository.js";
import pool from "../config/database.js";
import { buildPaginationQuery, PaginationOptions, PaginationResult } from "../utils/pagination.js";

export interface Asset {
  id: string;
  category_id: string;
  name: string;
  code: string;
  status: string;
  value: number;
  created_at: Date;
  updated_at: Date;
  deleted_at: Date | null;
}

export class AssetRepository extends BaseRepository<Asset> {
  constructor() {
    super("assets");
  }

  async findPaginated(options: PaginationOptions): Promise<PaginationResult<Asset>> {
    const baseQuery = "SELECT id, category_id, name, code, status, value, deleted_at FROM assets";
    const searchableFields = ["name", "code", "status"];
    
    const { countQuery, dataQuery, params, page, limit } = buildPaginationQuery(
      baseQuery,
      options,
      searchableFields,
      { categoryId: "category_id", status: "status" }
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

  async assignAsset(assetId: string, employeeId: string, notes?: string): Promise<void> {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");
      
      // Update asset status
      await client.query(
        "UPDATE assets SET status = 'Assigned', updated_at = CURRENT_TIMESTAMP WHERE id = $1",
        [assetId]
      );

      // Create asset assignment log
      await client.query(
        `INSERT INTO asset_assignments (asset_id, employee_id, assigned_date, notes) 
         VALUES ($1, $2, CURRENT_TIMESTAMP, $3)`,
        [assetId, employeeId, notes || null]
      );

      // Insert action history
      await client.query(
        `INSERT INTO asset_history (asset_id, action, details) 
         VALUES ($1, 'Assignment', $2)`,
        [assetId, `Assigned to employee ${employeeId}`]
      );

      await client.query("COMMIT");
    } catch (e) {
      await client.query("ROLLBACK");
      throw e;
    } finally {
      client.release();
    }
  }
}
