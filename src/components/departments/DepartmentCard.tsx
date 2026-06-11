import React from "react";
import { Card, Space, Button, Avatar } from "antd";
import { UserOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons";

interface DepartmentCardProps {
  dept: {
    id: string;
    name: string;
    code: string;
    head: string;
    employeeCount: number;
    budget: string;
  };
  onEdit: () => void;
  onDelete: () => void;
}

export const DepartmentCard: React.FC<DepartmentCardProps> = ({
  dept,
  onEdit,
  onDelete,
}) => {
  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "16px" }}>
        <div>
          <h3 style={{ margin: "0 0 4px 0", fontSize: "16px", fontWeight: 700, color: "#1e293b" }}>
            {dept.name}
          </h3>
          <span
            style={{
              display: "inline-block",
              background: "#eff6ff",
              color: "#0061FF",
              fontSize: "11px",
              fontWeight: 600,
              padding: "2px 6px",
              borderRadius: "4px",
            }}
          >
            {dept.code}
          </span>
        </div>
        <Space>
          <Button type="text" icon={<EditOutlined />} onClick={onEdit} />
          <Button type="text" danger icon={<DeleteOutlined />} onClick={onDelete} />
        </Space>
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: "12px", marginBottom: "16px", background: "#f8fafc", padding: "10px", borderRadius: "6px" }}>
        <Avatar icon={<UserOutlined />} style={{ backgroundColor: "#0061FF" }} />
        <div>
          <div style={{ fontSize: "11px", color: "#64748b" }}>Head of Department</div>
          <div style={{ fontSize: "13px", fontWeight: 600, color: "#334155" }}>{dept.head}</div>
        </div>
      </div>

      <div style={{ display: "flex", justifyContent: "space-between", fontSize: "13px", color: "#64748b" }}>
        <span>Staff Size: <strong>{dept.employeeCount}</strong></span>
        <span>Budget: <strong>{dept.budget}</strong></span>
      </div>
    </Card>
  );
};
