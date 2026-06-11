import React from "react";
import { Card, Table, Tag } from "antd";
import type { ColumnsType } from "antd/es/table";

interface AttendanceRecord {
  key: string;
  date: string;
  checkIn: string;
  checkOut: string;
  totalHours: string;
  status: "PRESENT" | "ABSENT" | "LATE";
}

const mockAttendanceData: AttendanceRecord[] = [
  { key: "1", date: "2026-06-10", checkIn: "08:58 AM", checkOut: "06:05 PM", totalHours: "9h 7m", status: "PRESENT" },
  { key: "2", date: "2026-06-09", checkIn: "09:15 AM", checkOut: "06:00 PM", totalHours: "8h 45m", status: "LATE" },
  { key: "3", date: "2026-06-08", checkIn: "08:50 AM", checkOut: "05:55 PM", totalHours: "9h 5m", status: "PRESENT" },
  { key: "4", date: "2026-06-07", checkIn: "09:02 AM", checkOut: "06:00 PM", totalHours: "8h 58m", status: "PRESENT" },
];

export const AttendanceInfoTab: React.FC = () => {
  const columns: ColumnsType<AttendanceRecord> = [
    { title: "Date", dataIndex: "date", key: "date" },
    { title: "Check In", dataIndex: "checkIn", key: "checkIn" },
    { title: "Check Out", dataIndex: "checkOut", key: "checkOut" },
    { title: "Total Hours", dataIndex: "totalHours", key: "totalHours" },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => {
        let color = "green";
        if (status === "LATE") color = "orange";
        if (status === "ABSENT") color = "red";
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
      title={<span style={{ fontWeight: 600 }}>Recent Attendance Logs</span>}
      bordered={false}
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
    >
      <Table columns={columns} dataSource={mockAttendanceData} pagination={false} />
    </Card>
  );
};
