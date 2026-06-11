import React from "react";
import { Table, Button, Space, Tag } from "antd";
import { CheckOutlined, CloseOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

export interface LeaveRequest {
  id: string;
  name: string;
  department: string;
  leaveType: string;
  dates: string;
  reason: string;
  status: "PENDING" | "APPROVED" | "REJECTED" | string;
}

interface LeaveTableProps {
  requests: LeaveRequest[];
  onApprove: (id: string) => void;
  onReject: (id: string) => void;
}

export const LeaveTable: React.FC<LeaveTableProps> = ({
  requests,
  onApprove,
  onReject,
}) => {
  const columns: ColumnsType<LeaveRequest> = [
    {
      title: "Employee",
      dataIndex: "name",
      key: "name",
      render: (text, record) => (
        <div>
          <span style={{ fontWeight: 600, color: "#1e293b" }}>{text}</span>
          <div style={{ fontSize: "12px", color: "#64748b" }}>{record.department}</div>
        </div>
      ),
    },
    { title: "Leave Type", dataIndex: "leaveType", key: "leaveType" },
    { title: "Dates", dataIndex: "dates", key: "dates" },
    { title: "Reason", dataIndex: "reason", key: "reason" },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => {
        let color = "orange";
        if (status === "APPROVED") color = "green";
        if (status === "REJECTED") color = "red";
        return (
          <Tag color={color} style={{ fontWeight: 600, borderRadius: "4px" }}>
            {status}
          </Tag>
        );
      },
    },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => {
        if (record.status !== "PENDING") return "--";
        return (
          <Space>
            <Button
              type="text"
              icon={<CheckOutlined />}
              onClick={() => onApprove(record.id)}
              style={{ color: "#16a34a" }}
            />
            <Button
              type="text"
              danger
              icon={<CloseOutlined />}
              onClick={() => onReject(record.id)}
            />
          </Space>
        );
      },
    },
  ];

  return (
    <Table
      columns={columns}
      dataSource={requests}
      rowKey="id"
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
    />
  );
};
