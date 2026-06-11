import React from "react";
import { Card, Button, Space } from "antd";
import { UserAddOutlined, CalendarOutlined, FileAddOutlined, DollarOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";
import { ROUTES } from "../../constants/routes";

export const QuickActions: React.FC = () => {
  const navigate = useNavigate();

  const actions = [
    {
      label: "Add Employee",
      icon: <UserAddOutlined />,
      onClick: () => navigate(ROUTES.EMPLOYEES),
      color: "#0061FF",
      bgColor: "#eff6ff",
    },
    {
      label: "Leave Applications",
      icon: <CalendarOutlined />,
      onClick: () => navigate(ROUTES.LEAVES),
      color: "#16a34a",
      bgColor: "#f0fdf4",
    },
    {
      label: "Attendance Logs",
      icon: <FileAddOutlined />,
      onClick: () => navigate(ROUTES.ATTENDANCE),
      color: "#d97706",
      bgColor: "#fef3c7",
    },
    {
      label: "Run Payroll Cycle",
      icon: <DollarOutlined />,
      onClick: () => navigate(ROUTES.PAYROLL),
      color: "#9333ea",
      bgColor: "#f3e8ff",
    },
  ];

  return (
    <Card
      title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Quick Actions</span>}
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
        height: "100%",
      }}
    >
      <Space orientation="vertical" style={{ width: "100%" }} size="middle">
        {actions.map((act, idx) => (
          <Button
            key={idx}
            type="text"
            onClick={act.onClick}
            style={{
              width: "100%",
              height: "48px",
              display: "flex",
              alignItems: "center",
              justifyContent: "flex-start",
              borderRadius: "6px",
              padding: "8px 16px",
              backgroundColor: "#f8fafc",
              border: "1px solid #e2e8f0",
            }}
          >
            <div
              style={{
                width: "32px",
                height: "32px",
                borderRadius: "6px",
                backgroundColor: act.bgColor,
                color: act.color,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                marginRight: "12px",
                fontSize: "16px",
              }}
            >
              {act.icon}
            </div>
            <span style={{ fontWeight: 500, fontSize: "14px", color: "#334155" }}>{act.label}</span>
          </Button>
        ))}
      </Space>
    </Card>
  );
};
