import { Routes, Route } from "react-router-dom";
import ProtectedRoute from "../../guards/ProtectedRoute";
import GuestRoute from "../../guards/GuestRoute";
import RoleGuard from "../../guards/RoleGuard";
import { ROUTES } from "../../constants/routes";
import { ROLES } from "../../constants/roles";

import AuthLayout from "../../layouts/AuthLayout";
import DashboardLayout from "../../layouts/DashboardLayout";
import EmployeeLayout from "../../layouts/EmployeeLayout";

import Login from "../../pages/auth/Login";
import ForgotPassword from "../../pages/auth/ForgotPassword";
import ResetPassword from "../../pages/auth/ResetPassword";

import DashboardPage from "../../pages/dashboard/DashboardPage";

import EmployeeDirectoryPage from "../../pages/employees/EmployeeDirectoryPage";

import EmployeeProfilePage from "../../pages/employees/EmployeeProfilePage";

import DepartmentPage from "../../pages/departments/DepartmentPage";
import TeamPage from "../../pages/teams/TeamPage";
import AttendancePage from "../../pages/attendance/AttendancePage";
import AssetPage from "../../pages/assets/AssetPage";
import LeavePage from "../../pages/leaves/LeavePage";
import PayrollPage from "../../pages/payroll/PayrollPage";
import ReportsPage from "../../pages/reports/ReportsPage";
import SettingsPage from "../../pages/settings/SettingsPage";
import NotFoundPage from "../../pages/NotFoundPage";

const AppRoutes = () => {
  return (
    <Routes>
      {/* Public / Guest Only Routes */}
      <Route element={<GuestRoute />}>
        <Route element={<AuthLayout />}>
          <Route path={ROUTES.LOGIN} element={<Login />} />
          <Route path={ROUTES.FORGOT_PASSWORD} element={<ForgotPassword />} />
          <Route path={ROUTES.RESET_PASSWORD} element={<ResetPassword />} />
        </Route>
      </Route>

      {/* Authenticated Protected Routes */}
      <Route element={<ProtectedRoute />}>
        <Route element={<DashboardLayout />}>
          <Route path={ROUTES.DASHBOARD} element={<DashboardPage />} />

          {/* HR & Manager & Admin Level Routes for Workforce Management */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.HR_ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.AUDITOR]} />}>
            <Route element={<EmployeeLayout />}>
              <Route path={ROUTES.EMPLOYEES} element={<EmployeeDirectoryPage />} />
            </Route>
            <Route path={ROUTES.DEPARTMENTS} element={<DepartmentPage />} />
          </Route>

          {/* Teams is accessible to Team Leads as well */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.HR_ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.TEAM_LEAD, ROLES.AUDITOR]} />}>
            <Route path="/teams" element={<TeamPage />} />
          </Route>

          <Route path={ROUTES.EMPLOYEE_PROFILE} element={<EmployeeProfilePage />} />

          {/* Time & Attendance - all except Payroll Admin */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.HR_ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.TEAM_LEAD, ROLES.EMPLOYEE, ROLES.INTERN, ROLES.AUDITOR]} />}>
            <Route path={ROUTES.ATTENDANCE} element={<AttendancePage />} />
            <Route path={ROUTES.LEAVES} element={<LeavePage />} />
          </Route>

          {/* Payroll - Admins, Payroll Admin, Employee, Intern, Auditor */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.PAYROLL_ADMIN, ROLES.EMPLOYEE, ROLES.INTERN, ROLES.AUDITOR]} />}>
            <Route path={ROUTES.PAYROLL} element={<PayrollPage />} />
          </Route>

          {/* Assets - Admins, HR, Auditor */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.HR_ADMIN, ROLES.HR, ROLES.AUDITOR]} />}>
            <Route path="/assets" element={<AssetPage />} />
          </Route>

          {/* Reports - Admins, HR, Manager, Auditor */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN, ROLES.HR_ADMIN, ROLES.HR, ROLES.MANAGER, ROLES.AUDITOR]} />}>
            <Route path="/reports" element={<ReportsPage />} />
          </Route>
          
          {/* Admin Only settings */}
          <Route element={<RoleGuard allowedRoles={[ROLES.SUPER_ADMIN, ROLES.ADMIN]} />}>
            <Route path={ROUTES.SETTINGS} element={<SettingsPage />} />
          </Route>
        </Route>
      </Route>

      {/* Wildcard Fallback */}
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
};

export default AppRoutes;