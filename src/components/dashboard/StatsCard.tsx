import React from "react";
import { Card } from "antd";
import { ArrowUpOutlined, ArrowDownOutlined } from "@ant-design/icons";

interface StatsCardProps {
  title: string;
  value: string | number;
  icon: React.ReactNode;
  trend?: {
    value: number;
    isPositive: boolean;
  };
  description?: string;
}

export const StatsCard: React.FC<StatsCardProps> = ({
  title,
  value,
  icon,
  trend,
  description,
}) => {
  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "12px" }}>
        <div>
          <span style={{ fontSize: "14px", color: "#64748b", fontWeight: 500 }}>{title}</span>
          <h2 style={{ fontSize: "28px", fontWeight: 700, color: "#1e293b", margin: "4px 0 0 0" }}>{value}</h2>
        </div>
        <div
          style={{
            background: "#eff6ff",
            color: "#0061FF",
            padding: "8px",
            borderRadius: "6px",
            fontSize: "20px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          {icon}
        </div>
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: "6px", flexWrap: "wrap" }}>
        {trend && (
          <span
            style={{
              fontSize: "12px",
              fontWeight: 600,
              color: trend.isPositive ? "#16a34a" : "#dc2626",
              display: "inline-flex",
              alignItems: "center",
              gap: "2px",
            }}
          >
            {trend.isPositive ? <ArrowUpOutlined /> : <ArrowDownOutlined />}
            {trend.value}%
          </span>
        )}
        {description && (
          <span style={{ fontSize: "12px", color: "#64748b" }}>{description}</span>
        )}
      </div>
    </Card>
  );
};
