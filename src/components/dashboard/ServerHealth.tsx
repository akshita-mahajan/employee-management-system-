import React from "react";
import { Card, Badge, Tooltip } from "antd";
import { CloudServerOutlined } from "@ant-design/icons";

export const ServerHealth: React.FC = () => {
  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
        background: "#fafafa",
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <div style={{ display: "flex", alignItems: "center", gap: "10px" }}>
          <CloudServerOutlined style={{ fontSize: "20px", color: "#64748b" }} />
          <div>
            <h5 style={{ margin: 0, fontSize: "13px", fontWeight: 600, color: "#1e293b" }}>
              API Services Health
            </h5>
            <span style={{ fontSize: "11px", color: "#64748b" }}>Latency: 42ms</span>
          </div>
        </div>
        <Tooltip title="All backend services operational">
          <Badge status="processing" color="green" text="Operational" style={{ fontWeight: 600 }} />
        </Tooltip>
      </div>
    </Card>
  );
};
