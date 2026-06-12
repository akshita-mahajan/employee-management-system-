export const ROLES = {
  SUPER_ADMIN: "SUPER_ADMIN",
  ADMIN: "ADMIN", // Legacy fallback
  HR_ADMIN: "HR_ADMIN",
  HR: "HR", // Legacy fallback
  PAYROLL_ADMIN: "PAYROLL_ADMIN",
  MANAGER: "MANAGER",
  TEAM_LEAD: "TEAM_LEAD",
  EMPLOYEE: "EMPLOYEE",
  INTERN: "INTERN",
  AUDITOR: "AUDITOR",
} as const;

export type UserRole = typeof ROLES[keyof typeof ROLES];

