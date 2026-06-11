import React from "react";
import { Table, Tag } from "antd";
import type { ColumnsType } from "antd/es/table";

export interface LogRecord {
  key: string;
  name: string;
  department: string;
  checkIn: string;
  checkOut: string;
  totalHours: string;
  status: "PRESENT" | "ABSENT" | "LATE" | string;
}

interface AttendanceLogsProps {
  logs: LogRecord[];
}

export const AttendanceLogs: React.FC<AttendanceLogsProps> = ({ logs }) => {
  const columns: ColumnsType<LogRecord> = [
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
    { title: "Check In Time", dataIndex: "checkIn", key: "checkIn" },
    { title: "Check Out Time", dataIndex: "checkOut", key: "checkOut" },
    { title: "Work Hours", dataIndex: "totalHours", key: "totalHours", render: (text) => <span style={{ fontWeight: 500 }}>{text || "--"}</span> },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => {
        let color = "green";
        if (status === "LATE") color = "orange";
        if (status === "ABSENT") color = "red";
        return (
          <Tag color={color} style={{ fontWeight: 600, borderRadius: "4px" }}>
            {status}
          </Tag>
        );
      },
    },
  ];

  return (
    <Table
      columns={columns}
      dataSource={logs}
      rowKey="key"
      pagination={{ pageSize: 5 }}
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
    />
  );
};
