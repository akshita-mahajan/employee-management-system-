import { Navigate, Outlet } from "react-router-dom";
import { useAuthStore } from "../app/store/authStore";
import { ROUTES } from "../constants/routes";

const ProtectedRoute = () => {
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);

  return isAuthenticated ? <Outlet /> : <Navigate to={ROUTES.LOGIN} replace />;
};

export default ProtectedRoute;