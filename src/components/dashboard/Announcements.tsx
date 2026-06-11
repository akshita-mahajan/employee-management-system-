import React from "react";
import { Card, Tag } from "antd";

interface Announcement {
  id: string;
  title: string;
  date: string;
  category: "General" | "Policy" | "Event";
  urgency: "High" | "Normal";
}

const mockAnnouncements: Announcement[] = [
  {
    id: "1",
    title: "New Remote Work Policy Updates starting July 1st",
    date: "Jun 10, 2026",
    category: "Policy",
    urgency: "High",
  },
  {
    id: "2",
    title: "Annual Office Retreat 2026 Registration Open",
    date: "Jun 08, 2026",
    category: "Event",
    urgency: "Normal",
  },
  {
    id: "3",
    title: "Q3 Performance Review Schedule Release",
    date: "Jun 05, 2026",
    category: "General",
    urgency: "Normal",
  },
];

export const Announcements: React.FC = () => {
  return (
    <Card
      title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Announcements</span>}
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
      }}
    >
      <div style={{ display: "flex", flexDirection: "column" }}>
        {mockAnnouncements.map((item) => (
          <div key={item.id} style={{ padding: "12px 0", borderBottom: "1px solid #f1f5f9" }}>
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "6px" }}>
              <span style={{ fontWeight: 600, color: "#1e293b", fontSize: "14px" }}>{item.title}</span>
              {item.urgency === "High" && <Tag color="red">High</Tag>}
            </div>
            <div style={{ display: "flex", gap: "8px", fontSize: "12px", color: "#64748b" }}>
              <span>{item.date}</span>
              <span>•</span>
              <span style={{ fontWeight: 500, color: "#0061FF" }}>{item.category}</span>
            </div>
          </div>
        ))}
      </div>
    </Card>
  );
};
