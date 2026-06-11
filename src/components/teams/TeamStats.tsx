import React from "react";
import { Row, Col, Card, Statistic } from "antd";
import { TeamOutlined, UserSwitchOutlined, CrownOutlined } from "@ant-design/icons";

interface TeamStatsProps {
  totalTeams: number;
  totalMembers: number;
  unassignedLeads: number;
}

export const TeamStats: React.FC<TeamStatsProps> = ({
  totalTeams,
  totalMembers,
  unassignedLeads,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Active Teams"
            value={totalTeams}
            prefix={<TeamOutlined style={{ marginRight: "8px", color: "#0061FF" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Total Team Members"
            value={totalMembers}
            prefix={<UserSwitchOutlined style={{ marginRight: "8px", color: "#16a34a" }} />}
          />
        </Card>
      </Col>
      <Col xs={24} sm={8}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Teams Awaiting Leads"
            value={unassignedLeads}
            prefix={<CrownOutlined style={{ marginRight: "8px", color: "#faad14" }} />}
          />
        </Card>
      </Col>
    </Row>
  );
};
