import React, { useState } from "react";
import { Tabs, Row, Col, notification } from "antd";

import { LeaveBalanceCard } from "../../components/leaves/LeaveBalanceCard";
import { LeaveCalendar } from "../../components/leaves/LeaveCalendar";
import { LeaveTable } from "../../components/leaves/LeaveTable";
import type { LeaveRequest } from "../../components/leaves/LeaveTable";

const mockLeaveRequests: LeaveRequest[] = [
  { id: "1", name: "Alice Miller", department: "Engineering", leaveType: "Sick Leave", dates: "Jun 12 - Jun 13", reason: "Fever and rest", status: "PENDING" },
  { id: "2", name: "Marcus Vance", department: "Product Management", leaveType: "Casual Leave", dates: "Jun 15 - Jun 17", reason: "Family trip", status: "PENDING" },
  { id: "3", name: "David Blake", department: "Marketing", leaveType: "Casual Leave", dates: "Jun 18 - Jun 19", reason: "Personal work", status: "APPROVED" },
];

const LeavePage: React.FC = () => {
  const [requests, setRequests] = useState<LeaveRequest[]>(mockLeaveRequests);

  const handleApprove = (id: string) => {
    setRequests(
      requests.map((r) => (r.id === id ? { ...r, status: "APPROVED" } : r))
    );
    const req = requests.find((r) => r.id === id);
    notification.success({
      message: "Request Approved",
      description: `Absence request for ${req?.name} approved.`,
    });
  };

  const handleReject = (id: string) => {
    setRequests(
      requests.map((r) => (r.id === id ? { ...r, status: "REJECTED" } : r))
    );
    const req = requests.find((r) => r.id === id);
    notification.success({
      message: "Request Rejected",
      description: `Absence request for ${req?.name} rejected.`,
    });
  };

  const tabItems = [
    {
      key: "requests",
      label: "Leave Applications",
      children: (
        <LeaveTable
          requests={requests}
          onApprove={handleApprove}
          onReject={handleReject}
        />
      ),
    },
    {
      key: "calendar",
      label: "Leave Calendar",
      children: <LeaveCalendar />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Absence & Leave Management
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Review pending leave applications, analyze category balances, and schedule calendars.
          </p>
        </Col>
      </Row>

      {/* KPI Section */}
      <LeaveBalanceCard />

      <Tabs defaultActiveKey="requests" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />
    </div>
  );
};

export default LeavePage;
