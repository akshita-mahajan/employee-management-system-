import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Layout, Menu, Drawer, theme } from "antd";
import {
  DashboardOutlined,
  TeamOutlined,
  ApartmentOutlined,
  UsergroupAddOutlined,
  CalendarOutlined,
  ScheduleOutlined,
  LaptopOutlined,
  WalletOutlined,
  BarChartOutlined,
  SettingOutlined,
} from "@ant-design/icons";

import { useUIStore } from "../../app/store/uiStore";
import { useAuthStore } from "../../app/store/authStore";
import { ROUTES } from "../../constants/routes";

import type { MenuProps } from "antd";

const { Sider } = Layout;

export const Sidebar: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { sidebarCollapsed, setSidebarCollapsed } = useUIStore();
  const [isMobile, setIsMobile] = useState(false);
  const { token } = theme.useToken();
  const { user } = useAuthStore();
  const role = user?.role || "EMPLOYEE";

  // Detect screen size to cleanly toggle between responsive drawer and desktop sider configurations
  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < 992);
    };
    handleResize();
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  const handleMenuClick = ({ key }: { key: string }) => {
    navigate(key);
    if (isMobile) {
      setSidebarCollapsed(true);
    }
  };

  const getFilteredMenuItems = (): MenuProps["items"] => {
    const items: MenuProps["items"] = [];

    // Dashboard is visible to all
    items.push({
      key: ROUTES.DASHBOARD,
      icon: <DashboardOutlined />,
      label: "Dashboard",
    });

    // Workforce Group (Super Admin, HR, Manager, Team Lead, Auditor)
    if (["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "TEAM_LEAD", "AUDITOR"].includes(role)) {
      const workforceChildren: any[] = [];
      
      // Employees list: Admins, HR, Manager, Auditor
      if (["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "AUDITOR"].includes(role)) {
        workforceChildren.push({
          key: ROUTES.EMPLOYEES,
          icon: <TeamOutlined />,
          label: "Employees",
        });
      }
      
      // Departments list: Admins, HR, Manager, Auditor
      if (["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "AUDITOR"].includes(role)) {
        workforceChildren.push({
          key: "/departments",
          icon: <ApartmentOutlined />,
          label: "Departments",
        });
      }
      
      // Teams: Admins, HR, Manager, Team Lead, Auditor
      workforceChildren.push({
        key: "/teams",
        icon: <UsergroupAddOutlined />,
        label: "Teams",
      });

      items.push({
        key: "workforce-group",
        label: "Workforce",
        type: "group",
        children: workforceChildren,
      });
    }

    // Time & Attendance (All except Payroll Admin)
    if (role !== "PAYROLL_ADMIN") {
      items.push({
        key: "time-group",
        label: "Time & Attendance",
        type: "group",
        children: [
          {
            key: ROUTES.ATTENDANCE,
            icon: <CalendarOutlined />,
            label: "Attendance Logs",
          },
          {
            key: ROUTES.LEAVES,
            icon: <ScheduleOutlined />,
            label: "Leaves Tracker",
          },
        ],
      });
    }

    // Finance (Super Admin, Admin, Payroll Admin, Employee, Intern, Auditor)
    if (["SUPER_ADMIN", "ADMIN", "PAYROLL_ADMIN", "EMPLOYEE", "INTERN", "AUDITOR"].includes(role)) {
      const financeChildren: any[] = [];
      
      financeChildren.push({
        key: ROUTES.PAYROLL,
        icon: <WalletOutlined />,
        label: "Payroll History",
      });

      // Assets only for Super Admin, Admin, HR, Auditor
      if (["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "AUDITOR"].includes(role)) {
        financeChildren.push({
          key: "/assets",
          icon: <LaptopOutlined />,
          label: "Asset Inventory",
        });
      }

      items.push({
        key: "finance-group",
        label: "Finance",
        type: "group",
        children: financeChildren,
      });
    }

    // Audit & Analysis / Reports (Super Admin, Admin, HR, Manager, Auditor)
    if (["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR", "MANAGER", "AUDITOR"].includes(role)) {
      items.push({
        key: "reports-group",
        label: "Audit & Analysis",
        type: "group",
        children: [
          {
            key: "/reports",
            icon: <BarChartOutlined />,
            label: "Reports",
          },
        ],
      });
    }

    // Administration (Super Admin / Admin only)
    if (["SUPER_ADMIN", "ADMIN"].includes(role)) {
      items.push({
        key: "admin-group",
        label: "Administration",
        type: "group",
        children: [
          {
            key: ROUTES.SETTINGS,
            icon: <SettingOutlined />,
            label: "Settings",
          },
        ],
      });
    }

    return items;
  };

  const menuItems = getFilteredMenuItems();

  if (isMobile) {
    return (
      <Drawer
        title="Enterprise HRMS"
        placement="left"
        onClose={() => setSidebarCollapsed(true)}
        open={!sidebarCollapsed}
        styles={{ body: { padding: 0 } }}
        size={256}
        className="mobile-sidebar-drawer"
      >
        <Menu
          mode="inline"
          selectedKeys={[location.pathname]}
          onClick={handleMenuClick}
          items={menuItems}
          style={{ height: "100%", borderRight: 0 }}
        />
      </Drawer>
    );
  }

  return (
    <Sider
      trigger={null}
      collapsible
      collapsed={sidebarCollapsed}
      width={256}
      collapsedWidth={80}
      style={{
        borderRight: `1px solid ${token.colorBorderSecondary}`,
        height: "100vh",
        position: "sticky",
        top: 0,
        left: 0,
        zIndex: 100,
        backgroundColor: token.colorBgContainer,
      }}
    >
      {/* Sider Logo brand block */}
      <div
        style={{
          height: "64px",
          display: "flex",
          alignItems: "center",
          padding: "0 24px",
          gap: "12px",
          borderBottom: `1px solid ${token.colorBorderSecondary}`,
        }}
      >
        <div
          style={{
            width: "32px",
            height: "32px",
            background: "linear-gradient(135deg, #0061FF 0%, #4A00E0 100%)",
            borderRadius: "6px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            fontWeight: 800,
            fontSize: "18px",
            color: "#ffffff",
            flexShrink: 0,
          }}
        >
          H
        </div>
        {!sidebarCollapsed && (
          <span style={{ fontSize: "16px", fontWeight: 700, color: token.colorText, letterSpacing: "0.2px" }}>
            Enterprise HRMS
          </span>
        )}
      </div>

      <Menu
        mode="inline"
        selectedKeys={[location.pathname]}
        onClick={handleMenuClick}
        items={menuItems}
        style={{
          height: "calc(100vh - 64px)",
          overflowY: "auto",
          borderRight: 0,
          paddingTop: "12px",
          backgroundColor: token.colorBgContainer,
        }}
      />
    </Sider>
  );
};
