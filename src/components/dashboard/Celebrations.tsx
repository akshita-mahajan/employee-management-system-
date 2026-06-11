import React from "react";
import { Card, Avatar } from "antd";
import { GiftOutlined, StarOutlined } from "@ant-design/icons";

interface EventItem {
  name: string;
  type: "birthday" | "anniversary";
  detail: string;
}

const mockEvents: EventItem[] = [
  { name: "John Doe", type: "birthday", detail: "Today" },
  { name: "Clarissa White", type: "anniversary", detail: "3 Years Work Anniversary (Tomorrow)" },
  { name: "Robert Downey", type: "birthday", detail: "June 14" },
  { name: "Scarlett Johansson", type: "anniversary", detail: "1 Year Work Anniversary (June 18)" },
];

export const Celebrations: React.FC = () => {
  return (
    <Card
      title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Celebrations</span>}
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
      }}
    >
      <div style={{ display: "flex", flexDirection: "column", gap: "12px" }}>
        {mockEvents.map((item, idx) => (
          <div key={idx} style={{ display: "flex", alignItems: "center", gap: "12px", padding: "8px 0" }}>
            <Avatar
              style={{
                backgroundColor: item.type === "birthday" ? "#fef2f2" : "#f0fdf4",
                color: item.type === "birthday" ? "#ef4444" : "#22c55e",
                flexShrink: 0,
              }}
              icon={item.type === "birthday" ? <GiftOutlined /> : <StarOutlined />}
            />
            <div style={{ display: "flex", flexDirection: "column" }}>
              <span style={{ fontWeight: 600, color: "#334155", fontSize: "14px" }}>{item.name}</span>
              <span style={{ fontSize: "12px", color: "#64748b" }}>{item.detail}</span>
            </div>
          </div>
        ))}
      </div>
    </Card>
  );
};
