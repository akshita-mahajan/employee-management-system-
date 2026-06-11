import React from "react";
import { Row, Col, Card, Statistic } from "antd";
import { DollarOutlined, BankOutlined, SafetyOutlined } from "@ant-design/icons";

interface PayrollStatsProps {
  totalPayout: string;
  avgCTC: string;
  totalDeductions: string;
}

export const PayrollStats: React.FC<PayrollStatsProps> = ({
  totalPayout,
  avgCTC,
  totalDeductions,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Monthly Payout"
            value={totalPayout}
            prefix={<DollarOutlined style={{ marginRight: "8px", color: "#0061FF" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Average Employee CTC"
            value={avgCTC}
            prefix={<BankOutlined style={{ marginRight: "8px", color: "#16a34a" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Combined Deductions"
            value={totalDeductions}
            prefix={<SafetyOutlined style={{ marginRight: "8px", color: "#ef4444" }} />}
          />
        </Card>
      </Col>
    </Row>
  );
};
