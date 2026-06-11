import React from "react";
import { Row, Col, Card, Statistic } from "antd";
import { CheckCircleOutlined, UserDeleteOutlined, ClockCircleOutlined, HourglassOutlined } from "@ant-design/icons";

interface AttendanceStatsProps {
  presentCount: number;
  absentCount: number;
  lateCount: number;
  avgHours: string;
}

export const AttendanceStats: React.FC<AttendanceStatsProps> = ({
  presentCount,
  absentCount,
  lateCount,
  avgHours,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Present Today"
            value={presentCount}
            prefix={<CheckCircleOutlined style={{ marginRight: "8px", color: "#16a34a" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Absent Today"
            value={absentCount}
            prefix={<UserDeleteOutlined style={{ marginRight: "8px", color: "#ef4444" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Late Today"
            value={lateCount}
            prefix={<ClockCircleOutlined style={{ marginRight: "8px", color: "#faad14" }} />}
          />
        </Card>
      </Col>
      <Col xs={12} sm={6}>
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <Statistic
            title="Average Work Hours"
            value={avgHours}
            prefix={<HourglassOutlined style={{ marginRight: "8px", color: "#0061FF" }} />}
          />
        </Card>
      </Col>
    </Row>
  );
};
