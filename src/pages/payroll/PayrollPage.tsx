import React, { useState } from "react";
import { Tabs, Row, Col, Space, Button, notification } from "antd";
import { PlayCircleOutlined } from "@ant-design/icons";

import { PayrollStats } from "../../components/payroll/PayrollStats";
import { PayslipViewer } from "../../components/payroll/PayslipViewer";
import { SalaryBreakdown } from "../../components/payroll/SalaryBreakdown";
import { PayrollTable } from "../../components/payroll/PayrollTable";
import type { PayrollRecord } from "../../components/payroll/PayrollTable";

const mockPayrollHistory: PayrollRecord[] = [
  { id: "1", month: "May 2026", totalPayout: "$425,000", status: "PROCESSED", employeeCount: 1248 },
  { id: "2", month: "April 2026", totalPayout: "$424,500", status: "PROCESSED", employeeCount: 1245 },
  { id: "3", month: "March 2026", totalPayout: "$418,000", status: "PROCESSED", employeeCount: 1240 },
  { id: "4", month: "June 2026 (Draft)", totalPayout: "$426,800", status: "PENDING", employeeCount: 1252 },
];

const PayrollPage: React.FC = () => {
  const [records, setRecords] = useState<PayrollRecord[]>(mockPayrollHistory);
  const [viewerOpen, setViewerOpen] = useState(false);
  const [selectedPayslip, setSelectedPayslip] = useState<any>(null);

  const handleRunPayroll = () => {
    // Check if draft June payroll is pending and process it
    const updated = records.map((r) => (r.status === "PENDING" ? { ...r, status: "PROCESSED" } : r));
    setRecords(updated);
    notification.success({
      message: "Payroll Run Dispatched",
      description: "Draft monthly payroll processed and payslips dispatched to employees.",
    });
  };

  const handleOpenViewer = (record: PayrollRecord) => {
    // Generate a detailed mock payslip model mapped from selection month
    setSelectedPayslip({
      month: record.month,
      employeeName: "John Admin",
      employeeId: "EMP-001",
      designation: "Lead HR Specialist",
      department: "Human Resources",
      earnings: {
        basic: 8500,
        hra: 3400,
        lta: 850,
      },
      deductions: {
        pf: 1020,
        tax: 430,
      },
    });
    setViewerOpen(true);
  };

  const tabItems = [
    {
      key: "history",
      label: "Payroll Payout Cycles",
      children: <PayrollTable records={records} onViewPayslip={handleOpenViewer} />,
    },
    {
      key: "breakdown",
      label: "Standard Salary Structure",
      children: <SalaryBreakdown />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Payroll & Expenses Management
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Track total monthly payouts, review base CTC structures, and process monthly salary cycles.
          </p>
        </Col>
        <Col>
          <Space>
            <Button
              type="primary"
              icon={<PlayCircleOutlined />}
              onClick={handleRunPayroll}
              style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
            >
              Run Payroll Cycle
            </Button>
          </Space>
        </Col>
      </Row>

      {/* KPI Section */}
      <PayrollStats
        totalPayout="$425,000"
        avgCTC="$116,400 / yr"
        totalDeductions="$45,500"
      />

      <Tabs defaultActiveKey="history" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />

      <PayslipViewer
        open={viewerOpen}
        onCancel={() => {
          setViewerOpen(false);
          setSelectedPayslip(null);
        }}
        payslip={selectedPayslip}
      />
    </div>
  );
};

export default PayrollPage;
