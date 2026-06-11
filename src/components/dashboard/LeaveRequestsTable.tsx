import React from "react";
import { Card, Table, Tag } from "antd";
import type { ColumnsType } from "antd/es/table";

interface LeaveRequest {
  id: string;
  employeeName: string;
  department: string;
  leaveType: string;
  duration: string;
  status: "PENDING" | "APPROVED" | "REJECTED";
}

const mockLeaveRequests: LeaveRequest[] = [
  {
    id: "1",
    employeeName: "Alice Miller",
    department: "Engineering",
    leaveType: "Sick Leave",
    duration: "2 days (Jun 12 - Jun 13)",
    status: "PENDING",
  },
  {
    id: "2",
    employeeName: "Marcus Vance",
    department: "Product Management",
    leaveType: "Casual Leave",
    duration: "3 days (Jun 15 - Jun 17)",
    status: "APPROVED",
  },
  {
    id: "3",
    employeeName: "David Blake",
    department: "Marketing",
    leaveType: "Maternity/Paternity",
    duration: "10 days (Jun 18 - Jun 28)",
    status: "PENDING",
  },
  {
    id: "4",
    employeeName: "Sarah Connor",
    department: "Human Resources",
    leaveType: "Casual Leave",
    duration: "1 day (Jun 14)",
    status: "REJECTED",
  },
];

export const LeaveRequestsTable: React.FC = () => {
  const columns: ColumnsType<LeaveRequest> = [
    {
      title: "Employee",
      dataIndex: "employeeName",
      key: "employeeName",
      render: (text, record) => (
        <div>
          <div style={{ fontWeight: 600, color: "#1e293b" }}>{text}</div>
          <div style={{ fontSize: "12px", color: "#64748b" }}>{record.department}</div>
        </div>
      ),
    },
    {
      title: "Leave Type",
      dataIndex: "leaveType",
      key: "leaveType",
    },
    {
      title: "Duration",
      dataIndex: "duration",
      key: "duration",
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
      title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Recent Leave Requests</span>}
      bordered={false}
      style={{
        borderRadius: "8px",
        boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
        border: "1px solid #e2e8f0",
      }}
    >
      <Table
        columns={columns}
        dataSource={mockLeaveRequests}
        rowKey="id"
        pagination={false}
        size="middle"
      />
    </Card>
  );
};
