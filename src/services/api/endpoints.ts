export const ENDPOINTS = {
  AUTH: {
    LOGIN: "/auth/login",
    REFRESH: "/auth/refresh",
    LOGOUT: "/auth/logout",
    FORGOT_PASSWORD: "/auth/forgot-password",
    RESET_PASSWORD: "/auth/reset-password",
    ME: "/auth/me",
  },
  EMPLOYEES: {
    LIST: "/employees",
    CREATE: "/employees",
    DETAIL: (id: string | number) => `/employees/${id}`,
    UPDATE: (id: string | number) => `/employees/${id}`,
    DELETE: (id: string | number) => `/employees/${id}`,
  },
  DEPARTMENTS: {
    LIST: "/departments",
  },
  DESIGNATIONS: {
    LIST: "/designations",
  },
} as const;
