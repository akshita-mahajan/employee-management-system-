import React from "react";
import { Card, Table, Tag } from "antd";
import type { ColumnsType } from "antd/es/table";
import { useLeaves } from "../../hooks/useHRMS";
import dayjs from "dayjs";

interface LeaveRequest {
  id: string;
  employee_name: string;
  leave_type_name: string;
  start_date: string;
  end_date: string;
  status: "PENDING" | "APPROVED" | "REJECTED" | string;
}

export const LeaveRequestsTable: React.FC = () => {
  const { data: leaves = [], isLoading } = useLeaves();

  // Slice recent 5 requests
  const recentLeaves = leaves.slice(0, 5);

  const columns: ColumnsType<LeaveRequest> = [
    {
      title: "Employee",
      dataIndex: "employee_name",
      key: "employee_name",
      render: (text) => (
        <span style={{ fontWeight: 600 }}>{text}</span>
      ),
    },
    {
      title: "Leave Type",
      dataIndex: "leave_type_name",
      key: "leave_type_name",
    },
    {
      title: "Duration",
      key: "duration",
      render: (_, record) => {
        const start = dayjs(record.start_date).format("MMM DD");
        const end = dayjs(record.end_date).format("MMM DD");
        const diff = dayjs(record.end_date).diff(dayjs(record.start_date), "day") + 1;
        return `${diff} days (${start} - ${end})`;
      },
    },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => {
        let color = "orange";
        if (status === "APPROVED") color = "green";
        if (status === "REJECTED") color = "red";
        return (
          <Tag color={color} style={{ fontWeight: 600 }}>
            {status}
          </Tag>
        );
      },
    },
  ];

  return (
    <Card
      title={
        <div>
          <span style={{ fontWeight: 600, fontSize: "16px" }}>Recent Leave Requests</span>
          <div style={{ fontSize: "12px", opacity: 0.6, fontWeight: 400 }}>Latest staff presence and absence filings</div>
        </div>
      }
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
        border: "1px solid rgba(0,0,0,0.05)",
      }}
    >
      <Table
        loading={isLoading}
        columns={columns}
        dataSource={recentLeaves}
        rowKey="id"
        pagination={false}
        size="middle"
      />
    </Card>
  );
};
