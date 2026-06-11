import React from "react";
import { useNavigate } from "react-router-dom";
import { Layout, Input, Badge, Dropdown, Avatar, Button, Space } from "antd";
import type { MenuProps } from "antd";
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  BellOutlined,
  SearchOutlined,
  UserOutlined,
  LogoutOutlined,
  SettingOutlined,
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
  const { sidebarCollapsed, toggleSidebar } = useUIStore();
  const { user, logout } = useAuthStore();
  const unreadCount = useNotificationStore((state) => state.getUnreadCount());

  const handleLogout = () => {
    logout();
    navigate(ROUTES.LOGIN);
  };

  const userMenuItems: MenuProps["items"] = [
    {
      key: "profile-header",
      label: (
        <div style={{ padding: "4px 8px" }}>
          <div style={{ fontWeight: 600, color: "#1e293b" }}>{user?.name || "User Account"}</div>
          <div style={{ fontSize: "12px", color: "#64748b" }}>{user?.email || "user@hrms.com"}</div>
          <div
            style={{
              display: "inline-block",
              background: "#eff6ff",
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
        background: "#ffffff",
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        height: "64px",
        borderBottom: "1px solid #e2e8f0",
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
            color: "#64748b",
          }}
        />
        <BreadcrumbSystem />
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: "20px" }}>
        {/* Search Input */}
        <Input
          prefix={<SearchOutlined style={{ color: "#94a3b8" }} />}
          placeholder="Search employees, tasks, docs..."
          style={{
            width: "260px",
            borderRadius: "6px",
            backgroundColor: "#f8fafc",
            border: "1px solid #e2e8f0",
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
                color: "#64748b",
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
              <span style={{ fontSize: "14px", fontWeight: 600, color: "#334155" }}>
                {user?.name || "HR Professional"}
              </span>
              <span style={{ fontSize: "11px", color: "#64748b" }}>
                {user?.role || "Admin"}
              </span>
            </div>
          </Space>
        </Dropdown>
      </div>
    </Header>
  );
};
