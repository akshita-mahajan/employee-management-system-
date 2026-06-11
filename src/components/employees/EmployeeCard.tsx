import React from "react";
import { Card, Avatar, Button } from "antd";
import { MailOutlined, PhoneOutlined, UserOutlined } from "@ant-design/icons";
import { Link } from "react-router-dom";

import { EmployeeStatusTag } from "./EmployeeStatusTag";

interface EmployeeCardProps {
  employee: {
    id: string;
    employeeId: string;
    name: string;
    department: string;
    designation: string;
    email: string;
    phone: string;
    status: string;
  };
}

export const EmployeeCard: React.FC<EmployeeCardProps> = ({ employee }) => {
  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
        textAlign: "center",
      }}
    >
      <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: "8px" }}>
        <EmployeeStatusTag status={employee.status} />
      </div>

      <Avatar
        size={64}
        icon={<UserOutlined />}
        style={{
          backgroundColor: "#eff6ff",
          color: "#0061FF",
          marginBottom: "12px",
        }}
      />

      <h4 style={{ margin: "0 0 4px 0", fontSize: "16px", fontWeight: 700, color: "#1e293b" }}>
        <Link to={`/employees/${employee.id}`} style={{ color: "inherit" }}>
          {employee.name}
        </Link>
      </h4>
      <p style={{ margin: "0 0 2px 0", fontSize: "13px", color: "#64748b", fontWeight: 500 }}>
        {employee.designation}
      </p>
      <p style={{ margin: "0 0 16px 0", fontSize: "12px", color: "#94a3b8" }}>
        {employee.department} • {employee.employeeId}
      </p>

      <div
        style={{
          borderTop: "1px solid #f1f5f9",
          paddingTop: "12px",
          display: "flex",
          justifyContent: "space-around",
        }}
      >
        <Button
          type="text"
          icon={<MailOutlined />}
          href={`mailto:${employee.email}`}
          style={{ color: "#64748b" }}
        />
        <Button
          type="text"
          icon={<PhoneOutlined />}
          href={`tel:${employee.phone}`}
          style={{ color: "#64748b" }}
        />
        <Button type="link" size="small" style={{ fontWeight: 600 }}>
          <Link to={`/employees/${employee.id}`}>View Profile</Link>
        </Button>
      </div>
    </Card>
  );
};
