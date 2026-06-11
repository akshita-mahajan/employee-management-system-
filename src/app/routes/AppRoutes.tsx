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

          {/* HR & Manager & Admin Level Routes */}
          <Route element={<RoleGuard allowedRoles={[ROLES.ADMIN, ROLES.HR, ROLES.MANAGER]} />}>
            <Route element={<EmployeeLayout />}>
              <Route path={ROUTES.EMPLOYEES} element={<EmployeeDirectoryPage />} />
            </Route>
            <Route path={ROUTES.DEPARTMENTS} element={<DepartmentPage />} />
            <Route path="/teams" element={<TeamPage />} />
          </Route>

          <Route path={ROUTES.EMPLOYEE_PROFILE} element={<EmployeeProfilePage />} />
          <Route path={ROUTES.ATTENDANCE} element={<AttendancePage />} />
          <Route path={ROUTES.LEAVES} element={<LeavePage />} />
          <Route path={ROUTES.PAYROLL} element={<PayrollPage />} />
          <Route path="/assets" element={<AssetPage />} />
          <Route path="/reports" element={<ReportsPage />} />
          
          {/* Admin Only settings */}
          <Route element={<RoleGuard allowedRoles={[ROLES.ADMIN]} />}>
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