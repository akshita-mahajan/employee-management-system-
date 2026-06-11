import React, { useState } from "react";
import { Tabs, Button, Row, Col, Space, notification } from "antd";
import { LoginOutlined, LogoutOutlined } from "@ant-design/icons";

import { AttendanceStats } from "../../components/attendance/AttendanceStats";
import { AttendanceCharts } from "../../components/attendance/AttendanceCharts";
import { AttendanceLogs } from "../../components/attendance/AttendanceLogs";
import type { LogRecord } from "../../components/attendance/AttendanceLogs";

const mockAttendanceLogs: LogRecord[] = [
  { key: "1", name: "Jane Miller", department: "Engineering", checkIn: "08:58 AM", checkOut: "06:05 PM", totalHours: "9h 7m", status: "PRESENT" },
  { key: "2", name: "Alice Vance", department: "Product Management", checkIn: "09:15 AM", checkOut: "06:00 PM", totalHours: "8h 45m", status: "LATE" },
  { key: "3", name: "Robert Downey", department: "Marketing", checkIn: "08:50 AM", checkOut: "05:55 PM", totalHours: "9h 5m", status: "PRESENT" },
  { key: "4", name: "John Admin", department: "Human Resources", checkIn: "09:02 AM", checkOut: "--", totalHours: "--", status: "PRESENT" },
];

const AttendancePage: React.FC = () => {
  const [logs, setLogs] = useState<LogRecord[]>(mockAttendanceLogs);
  const [isClockedIn, setIsClockedIn] = useState(false);

  const handleClockIn = () => {
    setIsClockedIn(true);
    const now = new Date();
    const timeStr = now.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" });
    const newLog: LogRecord = {
      key: (logs.length + 1).toString(),
      name: "John Admin",
      department: "Human Resources",
      checkIn: timeStr,
      checkOut: "--",
      totalHours: "--",
      status: "PRESENT",
    };
    setLogs([newLog, ...logs]);
    notification.success({
      message: "Clocked In Successfully",
      description: `Welcome! Clock-in timestamp logged at ${timeStr}.`,
    });
  };

  const handleClockOut = () => {
    setIsClockedIn(false);
    const now = new Date();
    const timeStr = now.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" });
    setLogs(
      logs.map((log) => {
        if (log.name === "John Admin" && log.checkOut === "--") {
          return {
            ...log,
            checkOut: timeStr,
            totalHours: "8h 30m", // Simulated diff representation
          };
        }
        return log;
      })
    );
    notification.success({
      message: "Clocked Out Successfully",
      description: `Good day! Clock-out timestamp logged at ${timeStr}.`,
    });
  };

  const tabItems = [
    {
      key: "logs",
      label: "Attendance Logs",
      children: <AttendanceLogs logs={logs} />,
    },
    {
      key: "analytics",
      label: "Analytics & Trends",
      children: <AttendanceCharts />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Attendance & Shifts
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Track daily presence timestamps, review average work metrics, and configure team shifts.
          </p>
        </Col>
        <Col>
          <Space>
            {!isClockedIn ? (
              <Button
                type="primary"
                icon={<LoginOutlined />}
                onClick={handleClockIn}
                style={{ backgroundColor: "#16a34a", borderRadius: "6px", height: "40px" }}
              >
                Clock In
              </Button>
            ) : (
              <Button
                type="primary"
                danger
                icon={<LogoutOutlined />}
                onClick={handleClockOut}
                style={{ borderRadius: "6px", height: "40px" }}
              >
                Clock Out
              </Button>
            )}
          </Space>
        </Col>
      </Row>

      {/* KPI Section */}
      <AttendanceStats
        presentCount={logs.filter((l) => l.status === "PRESENT" || l.status === "LATE").length}
        absentCount={1}
        lateCount={logs.filter((l) => l.status === "LATE").length}
        avgHours="8.5h"
      />

      <Tabs defaultActiveKey="logs" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />
    </div>
  );
};

export default AttendancePage;
