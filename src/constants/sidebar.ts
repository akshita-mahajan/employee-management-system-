import { ROUTES } from "./routes";
import { ROLES } from "./roles";
import type { UserRole } from "./roles";

export interface SidebarItem {
  key: string;
  label: string;
  path: string;
  icon?: string;
  roles?: UserRole[];
  children?: SidebarItem[];
}

export const sidebarConfig: SidebarItem[] = [
  {
    key: "dashboard",
    label: "Dashboard",
    path: ROUTES.DASHBOARD,
    icon: "DashboardOutlined",
    roles: [ROLES.ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.EMPLOYEE],
  },
  {
    key: "employees",
    label: "Employees",
    path: ROUTES.EMPLOYEES,
    icon: "TeamOutlined",
    roles: [ROLES.ADMIN, ROLES.HR, ROLES.MANAGER],
  },
  {
    key: "attendance",
    label: "Attendance",
    path: ROUTES.ATTENDANCE,
    icon: "CalendarOutlined",
    roles: [ROLES.ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.EMPLOYEE],
  },
  {
    key: "leaves",
    label: "Leaves",
    path: ROUTES.LEAVES,
    icon: "FileProtectOutlined",
    roles: [ROLES.ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.EMPLOYEE],
  },
  {
    key: "payroll",
    label: "Payroll",
    path: ROUTES.PAYROLL,
    icon: "DollarOutlined",
    roles: [ROLES.ADMIN, ROLES.HR, ROLES.EMPLOYEE],
  },
  {
    key: "settings",
    label: "Settings",
    path: ROUTES.SETTINGS,
    icon: "SettingOutlined",
    roles: [ROLES.ADMIN],
  },
];
