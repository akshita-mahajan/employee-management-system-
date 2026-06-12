import React from "react";
import { useNavigate } from "react-router-dom";
import { Layout, Input, Badge, Dropdown, Avatar, Button, Space, theme } from "antd";
import type { MenuProps } from "antd";
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  BellOutlined,
  SearchOutlined,
  UserOutlined,
  LogoutOutlined,
  SettingOutlined,
  SunOutlined,
  MoonOutlined,
} from "@ant-design/icons";

import { useUIStore } from "../../app/store/uiStore";
import { useAuthStore } from "../../app/store/authStore";
import { useNotificationStore } from "../../app/store/notificationStore";
import { NotificationPanel } from "./NotificationPanel";
import { BreadcrumbSystem } from "./BreadcrumbSystem";
import { ROUTES } from "../../constants/routes";

const { Header } = Layout;

export const Navbar: React.FC = () => {
  const navigate = useNavigate();
  const { sidebarCollapsed, toggleSidebar, themeMode, setThemeMode } = useUIStore();
  const { user, logout } = useAuthStore();
  const unreadCount = useNotificationStore((state) => state.getUnreadCount());
  const { token } = theme.useToken();

  const handleLogout = () => {
    logout();
    navigate(ROUTES.LOGIN);
  };

  const toggleTheme = () => {
    setThemeMode(themeMode === "light" ? "dark" : "light");
  };

  const userMenuItems: MenuProps["items"] = [
    {
      key: "profile-header",
      label: (
        <div style={{ padding: "4px 8px" }}>
          <div style={{ fontWeight: 600, color: token.colorText }}>{user?.name || "User Account"}</div>
          <div style={{ fontSize: "12px", color: token.colorTextSecondary }}>{user?.email || "user@hrms.com"}</div>
          <div
            style={{
              display: "inline-block",
              background: themeMode === "dark" ? "#1e293b" : "#eff6ff",
              color: "#0061FF",
              fontSize: "11px",
              fontWeight: 600,
              padding: "2px 6px",
              borderRadius: "4px",
              marginTop: "4px",
            }}
          >
            {user?.role || "EMPLOYEE"}
          </div>
        </div>
      ),
      type: "group",
    },
    {
      type: "divider",
    },
    {
      key: "settings",
      icon: <SettingOutlined />,
      label: "My Settings",
      onClick: () => navigate(ROUTES.SETTINGS),
    },
    {
      key: "logout",
      icon: <LogoutOutlined />,
      label: "Sign Out",
      danger: true,
      onClick: handleLogout,
    },
  ];

  return (
    <Header
      style={{
        padding: "0 24px",
        background: token.colorBgContainer,
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        height: "64px",
        borderBottom: `1px solid ${token.colorBorderSecondary}`,
        position: "sticky",
        top: 0,
        zIndex: 99,
      }}
    >
      <div style={{ display: "flex", alignItems: "center", gap: "16px" }}>
        <Button
          type="text"
          icon={sidebarCollapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
          onClick={toggleSidebar}
          style={{
            fontSize: "16px",
            width: "40px",
            height: "40px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            color: token.colorTextSecondary,
          }}
        />
        <BreadcrumbSystem />
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: "20px" }}>
        {/* Search Input */}
        <Input
          prefix={<SearchOutlined style={{ color: token.colorTextPlaceholder }} />}
          placeholder="Search employees, tasks, docs..."
          style={{
            width: "260px",
            borderRadius: "6px",
            backgroundColor: themeMode === "dark" ? "#1f1f1f" : "#f8fafc",
            border: `1px solid ${token.colorBorder}`,
            color: token.colorText,
          }}
        />

        {/* Theme Toggle Button */}
        <Button
          type="text"
          icon={themeMode === "light" ? <MoonOutlined /> : <SunOutlined />}
          onClick={toggleTheme}
          style={{
            fontSize: "18px",
            color: token.colorTextSecondary,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            width: "40px",
            height: "40px",
          }}
        />

        {/* Notifications Icon Dropdown */}
        <Dropdown dropdownRender={() => <NotificationPanel />} trigger={["click"]} placement="bottomRight">
          <Badge count={unreadCount} size="small" offset={[-2, 4]} color="#0061FF" style={{ cursor: "pointer" }}>
            <Button
              type="text"
              icon={<BellOutlined />}
              style={{
                fontSize: "20px",
                color: token.colorTextSecondary,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                width: "40px",
                height: "40px",
              }}
            />
          </Badge>
        </Dropdown>

        {/* Profile Avatar Dropdown */}
        <Dropdown menu={{ items: userMenuItems }} trigger={["click"]} placement="bottomRight">
          <Space style={{ cursor: "pointer" }}>
            <Avatar
              style={{ backgroundColor: "#0061FF", verticalAlign: "middle" }}
              icon={<UserOutlined />}
            />
            <div style={{ display: "flex", flexDirection: "column", lineHeight: 1.2 }}>
              <span style={{ fontSize: "14px", fontWeight: 600, color: token.colorText }}>
                {user?.name || "HR Professional"}
              </span>
              <span style={{ fontSize: "11px", color: token.colorTextSecondary }}>
                {user?.role || "Admin"}
              </span>
            </div>
          </Space>
        </Dropdown>
      </div>
    </Header>
  );
};
