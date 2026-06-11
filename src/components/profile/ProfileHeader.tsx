import React from "react";
import { Card, Row, Col, Avatar, Button, Space } from "antd";
import { UserOutlined, MailOutlined, PhoneOutlined } from "@ant-design/icons";
import { EmployeeStatusTag } from "../../components/employees/EmployeeStatusTag";

interface ProfileHeaderProps {
  employee: {
    employeeId: string;
    name: string;
    department: string;
    designation: string;
    email: string;
    phone: string;
    status: string;
  };
}

export const ProfileHeader: React.FC<ProfileHeaderProps> = ({ employee }) => {
  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "12px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
        marginBottom: "24px",
        padding: "12px",
      }}
    >
      <Row gutter={[24, 24]} align="middle">
        <Col xs={24} md={16}>
          <div style={{ display: "flex", gap: "20px", alignItems: "center", flexWrap: "wrap" }}>
            <Avatar
              size={96}
              icon={<UserOutlined />}
              style={{ backgroundColor: "#eff6ff", color: "#0061FF" }}
            />
            <div>
              <div style={{ display: "flex", alignItems: "center", gap: "12px", flexWrap: "wrap" }}>
                <h1 style={{ fontSize: "24px", fontWeight: 700, margin: 0, color: "#1e293b" }}>
                  {employee.name}
                </h1>
                <EmployeeStatusTag status={employee.status} />
              </div>
              <p style={{ margin: "4px 0 8px 0", fontSize: "15px", color: "#64748b", fontWeight: 500 }}>
                {employee.designation} • {employee.department}
              </p>
              <div style={{ display: "flex", gap: "16px", color: "#64748b", fontSize: "14px", flexWrap: "wrap" }}>
                <span>
                  <MailOutlined style={{ marginRight: "6px" }} />
                  {employee.email}
                </span>
                <span>
                  <PhoneOutlined style={{ marginRight: "6px" }} />
                  {employee.phone}
                </span>
                <span>ID: {employee.employeeId}</span>
              </div>
            </div>
          </div>
        </Col>

        <Col xs={24} md={8} style={{ display: "flex", justifyContent: "flex-end" }}>
          <Space>
            <Button style={{ borderRadius: "6px" }}>Edit Profile</Button>
            <Button type="primary" style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}>
              Request Leave
            </Button>
          </Space>
        </Col>
      </Row>
    </Card>
  );
};
