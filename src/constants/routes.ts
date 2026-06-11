export const ROUTES = {
  LOGIN: "/login",
  FORGOT_PASSWORD: "/forgot-password",
  RESET_PASSWORD: "/reset-password",
  DASHBOARD: "/",
  EMPLOYEES: "/employees",
  EMPLOYEE_PROFILE: "/employees/:id",
  DEPARTMENTS: "/departments",
  ATTENDANCE: "/attendance",
  LEAVES: "/leaves",
  PAYROLL: "/payroll",
  SETTINGS: "/settings",
} as const;

export type RouteKeys = keyof typeof ROUTES;
export type RouteValues = typeof ROUTES[RouteKeys];
