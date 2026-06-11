export const EMPLOYEE_STATUS = {
  ACTIVE: "ACTIVE",
  INACTIVE: "INACTIVE",
  TERMINATED: "TERMINATED",
  ON_LEAVE: "ON_LEAVE",
} as const;

export type EmployeeStatus = keyof typeof EMPLOYEE_STATUS;

export const LEAVE_STATUS = {
  PENDING: "PENDING",
  APPROVED: "APPROVED",
  REJECTED: "REJECTED",
  CANCELLED: "CANCELLED",
} as const;

export type LeaveStatus = keyof typeof LEAVE_STATUS;
