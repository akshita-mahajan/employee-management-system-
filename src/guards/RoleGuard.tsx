import { Navigate, Outlet } from "react-router-dom";
import { useAuthStore } from "../app/store/authStore";
import type { UserRole } from "../constants/roles";
import { ROUTES } from "../constants/routes";

interface RoleGuardProps {
  allowedRoles: UserRole[];
}

const RoleGuard = ({ allowedRoles }: RoleGuardProps) => {
  const { user, isAuthenticated } = useAuthStore();

  if (!isAuthenticated) {
    return <Navigate to={ROUTES.LOGIN} replace />;
  }

  // If user role is not inside the allowedRoles array, redirect to Dashboard
  const hasAccess = user && allowedRoles.includes(user.role);

  return hasAccess ? <Outlet /> : <Navigate to={ROUTES.DASHBOARD} replace />;
};

export default RoleGuard;
