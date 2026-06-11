import React from "react";
import { Card, Space, Button, Avatar, Tooltip } from "antd";
import { UserOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons";

interface TeamCardProps {
  team: {
    id: string;
    name: string;
    code: string;
    department: string;
    lead: string;
    membersCount: number;
    membersList: string[];
  };
  onEdit: () => void;
  onDelete: () => void;
}

export const TeamCard: React.FC<TeamCardProps> = ({
  team,
  onEdit,
  onDelete,
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
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "16px" }}>
        <div>
          <h3 style={{ margin: "0 0 4px 0", fontSize: "16px", fontWeight: 700, color: "#1e293b" }}>
            {team.name}
          </h3>
          <span
            style={{
              display: "inline-block",
              background: "#f1f5f9",
              color: "#475569",
              fontSize: "11px",
              fontWeight: 600,
              padding: "2px 6px",
              borderRadius: "4px",
            }}
          >
            {team.code} • {team.department}
          </span>
        </div>
        <Space>
          <Button type="text" icon={<EditOutlined />} onClick={onEdit} />
          <Button type="text" danger icon={<DeleteOutlined />} onClick={onDelete} />
        </Space>
      </div>

      <div style={{ marginBottom: "16px" }}>
        <div style={{ fontSize: "11px", color: "#64748b", marginBottom: "4px" }}>Team Lead</div>
        <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
          <Avatar size="small" icon={<UserOutlined />} style={{ backgroundColor: "#0061FF" }} />
          <span style={{ fontSize: "13px", fontWeight: 600, color: "#334155" }}>{team.lead || "Unassigned"}</span>
        </div>
      </div>

      <div>
        <div style={{ fontSize: "11px", color: "#64748b", marginBottom: "6px" }}>Members ({team.membersCount})</div>
        <Avatar.Group max={{ count: 4, style: { color: '#f56a00', backgroundColor: '#fde3cf' } }}>
          {team.membersList.map((m, idx) => (
            <Tooltip title={m} key={idx}>
              <Avatar style={{ backgroundColor: "#16a34a" }}>{m[0]}</Avatar>
            </Tooltip>
          ))}
        </Avatar.Group>
      </div>
    </Card>
  );
};
