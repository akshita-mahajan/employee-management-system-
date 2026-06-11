import React from "react";
import { Row, Col, Card, Progress } from "antd";

interface Balance {
  type: string;
  allocated: number;
  used: number;
  available: number;
  color: string;
}

const mockBalances: Balance[] = [
  { type: "Casual Leave", allocated: 12, used: 4, available: 8, color: "#0061FF" },
  { type: "Sick Leave", allocated: 10, used: 3, available: 7, color: "#16a34a" },
  { type: "Earned Leave", allocated: 18, used: 6, available: 12, color: "#9333ea" },
];

export const LeaveBalanceCard: React.FC = () => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
      {mockBalances.map((bal, idx) => {
        const percent = Math.round((bal.available / bal.allocated) * 100);
        return (
          <Col xs={24} sm={8} key={idx}>
            <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <div>
                  <div style={{ fontSize: "14px", color: "#64748b", fontWeight: 500 }}>{bal.type}</div>
                  <h2 style={{ fontSize: "28px", fontWeight: 700, color: "#1e293b", margin: "8px 0 4px 0" }}>
                    {bal.available}
                  </h2>
                  <span style={{ fontSize: "12px", color: "#94a3b8" }}>
                    Used: {bal.used} / {bal.allocated} Days
                  </span>
                </div>
                <Progress type="circle" percent={percent} strokeColor={bal.color} width={64} strokeWidth={8} />
              </div>
            </Card>
          </Col>
        );
      })}
    </Row>
  );
};
