import React from "react";
import { Row, Col, Card, Statistic } from "antd";
import { AppstoreOutlined, UserOutlined, DollarOutlined } from "@ant-design/icons";

interface DepartmentStatsProps {
  totalDepartments: number;
  totalEmployees: number;
  totalBudget: string;
}

export const DepartmentStats: React.FC<DepartmentStatsProps> = ({
  totalDepartments,
  totalEmployees,
  totalBudget,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Departments"
            value={totalDepartments}
            prefix={<AppstoreOutlined style={{ marginRight: "8px", color: "#0061FF" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Allocated Staff"
            value={totalEmployees}
            prefix={<UserOutlined style={{ marginRight: "8px", color: "#16a34a" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Combined Budget"
            value={totalBudget}
            prefix={<DollarOutlined style={{ marginRight: "8px", color: "#9333ea" }} />}
          />
        </Card>
      </Col>
    </Row>
  );
};
