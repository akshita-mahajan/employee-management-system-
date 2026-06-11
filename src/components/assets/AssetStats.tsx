import React from "react";
import { Row, Col, Card, Statistic } from "antd";
import { LaptopOutlined, CheckCircleOutlined, AlertOutlined, ToolOutlined } from "@ant-design/icons";

interface AssetStatsProps {
  total: number;
  assigned: number;
  available: number;
  maintenance: number;
}

export const AssetStats: React.FC<AssetStatsProps> = ({
  total,
  assigned,
  available,
  maintenance,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Assets"
            value={total}
            prefix={<LaptopOutlined style={{ marginRight: "8px", color: "#0061FF" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Assigned"
            value={assigned}
            prefix={<CheckCircleOutlined style={{ marginRight: "8px", color: "#16a34a" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Available"
            value={available}
            prefix={<AlertOutlined style={{ marginRight: "8px", color: "#faad14" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Under Maintenance"
            value={maintenance}
            prefix={<ToolOutlined style={{ marginRight: "8px", color: "#ef4444" }} />}
          />
        </Card>
      </Col>
    </Row>
  );
};
