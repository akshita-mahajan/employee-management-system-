import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Layout, Menu, Drawer } from "antd";
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
import { ROUTES } from "../../constants/routes";

import type { MenuProps } from "antd";

const { Sider } = Layout;

export const Sidebar: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { sidebarCollapsed, setSidebarCollapsed } = useUIStore();
  const [isMobile, setIsMobile] = useState(false);

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

  const menuItems: MenuProps["items"] = [
    {
      key: ROUTES.DASHBOARD,
      icon: <DashboardOutlined />,
      label: "Dashboard",
    },
    {
      key: "workforce-group",
      label: "Workforce",
      type: "group",
      children: [
        {
          key: ROUTES.EMPLOYEES,
          icon: <TeamOutlined />,
          label: "Employees",
        },
        {
          key: "/departments",
          icon: <ApartmentOutlined />,
          label: "Departments",
        },
        {
          key: "/teams",
          icon: <UsergroupAddOutlined />,
          label: "Teams",
        },
      ],
    },
    {
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
    },
    {
      key: "finance-group",
      label: "Finance",
      type: "group",
      children: [
        {
          key: ROUTES.PAYROLL,
          icon: <WalletOutlined />,
          label: "Payroll History",
        },
        {
          key: "/assets",
          icon: <LaptopOutlined />,
          label: "Asset Inventory",
        },
      ],
    },
    {
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
    },
    {
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
    },
  ];

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
        borderRight: "1px solid #e2e8f0",
        height: "100vh",
        position: "sticky",
        top: 0,
        left: 0,
        zIndex: 100,
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
          borderBottom: "1px solid #e2e8f0",
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
          <span style={{ fontSize: "16px", fontWeight: 700, color: "#1e293b", letterSpacing: "0.2px" }}>
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
        }}
      />
    </Sider>
  );
};
