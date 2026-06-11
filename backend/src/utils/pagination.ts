export interface PaginationOptions {
  page?: number;
  limit?: number;
  search?: string;
  sortBy?: string;
  sortOrder?: "ASC" | "DESC";
  filters?: Record<string, any>;
}

export interface PaginationResult<T> {
  data: T[];
  metadata: {
    total: number;
    page: number;
    limit: number;
    totalPages: number;
  };
}

export const buildPaginationQuery = (
  baseQuery: string,
  options: PaginationOptions,
  searchableFields: string[],
  filterMappings: Record<string, string> = {}
) => {
  const page = Math.max(1, options.page || 1);
  const limit = Math.max(1, options.limit || 10);
  const offset = (page - 1) * limit;

  const sqlParams: any[] = [];
  const whereClauses: string[] = ["deleted_at IS NULL"];

  // Search Logic
  if (options.search && searchableFields.length > 0) {
    const searchParamIndex = sqlParams.push(`%${options.search}%`);
    const searchConditions = searchableFields
      .map((field) => `${field} ILIKE $${searchParamIndex}`)
      .join(" OR ");
    whereClauses.push(`(${searchConditions})`);
  }

  // Filters Logic
  if (options.filters) {
    for (const [key, value] of Object.entries(options.filters)) {
      if (value !== undefined && value !== null && value !== "") {
        const dbField = filterMappings[key] || key;
        const paramIdx = sqlParams.push(value);
        whereClauses.push(`${dbField} = $${paramIdx}`);
      }
    }
  }

  const whereString = whereClauses.length > 0 ? `WHERE ${whereClauses.join(" AND ")}` : "";

  // Sort Logic
  let orderString = "";
  if (options.sortBy) {
    const direction = options.sortOrder === "DESC" ? "DESC" : "ASC";
    orderString = `ORDER BY ${options.sortBy} ${direction}`;
  }

  // Combine query parts
  const countQuery = `SELECT COUNT(*)::int as total FROM (${baseQuery}) as count_base ${whereString}`;
  
  const limitParamIndex = sqlParams.push(limit);
  const offsetParamIndex = sqlParams.push(offset);
  const dataQuery = `
    SELECT * FROM (${baseQuery}) as data_base 
    ${whereString} 
    ${orderString} 
    LIMIT $${limitParamIndex} OFFSET $${offsetParamIndex}
  `;

  return {
    countQuery,
    dataQuery,
    params: sqlParams,
    page,
    limit,
  };
};
