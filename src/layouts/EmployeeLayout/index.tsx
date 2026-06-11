import { Outlet } from "react-router-dom";

const EmployeeLayout = () => {
  return (
    <div style={{ padding: "16px" }}>
      <Outlet />
    </div>
  );
};

export default EmployeeLayout;
