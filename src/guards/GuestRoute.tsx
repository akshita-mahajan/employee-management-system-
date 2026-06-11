import { Navigate, Outlet } from "react-router-dom";
import { useAuthStore } from "../app/store/authStore";
import { ROUTES } from "../constants/routes";

const GuestRoute = () => {
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);

  return isAuthenticated ? <Navigate to={ROUTES.DASHBOARD} replace /> : <Outlet />;
};

export default GuestRoute;
