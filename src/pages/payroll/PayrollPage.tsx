import React, { useState } from "react";
import { Tabs, Row, Col, Space, Button, notification, Spin } from "antd";
import { PlayCircleOutlined } from "@ant-design/icons";

import { PayrollStats } from "../../components/payroll/PayrollStats";
import { PayslipViewer } from "../../components/payroll/PayslipViewer";
import { SalaryBreakdown } from "../../components/payroll/SalaryBreakdown";
import { PayrollTable } from "../../components/payroll/PayrollTable";
import type { PayrollRecord } from "../../components/payroll/PayrollTable";
import { usePayrollRuns, useRunPayroll } from "../../hooks/useHRMS";

const PayrollPage: React.FC = () => {
  const { data: rawRuns = [], isLoading } = usePayrollRuns();
  const runPayrollMutation = useRunPayroll();

  const [viewerOpen, setViewerOpen] = useState(false);
  const [selectedPayslip, setSelectedPayslip] = useState<any>(null);

  // Map backend runs to Table layout format
  const records: PayrollRecord[] = rawRuns.map((r: any) => ({
    id: r.id,
    month: r.billing_month,
    totalPayout: `₹${(parseFloat(r.total_payout) || 0).toLocaleString("en-IN")}`,
    status: r.status,
    employeeCount: r.employee_count || 65,
  }));

  const handleRunPayroll = async () => {
    try {
      await runPayrollMutation.mutateAsync({
        billingMonth: "July 2026",
      });
      notification.success({
        message: "Payroll Run Dispatched",
        description: "Draft monthly payroll processed and payslips dispatched to employees.",
      });
    } catch (error: any) {
      notification.error({
        message: "Run Payroll Failed",
        description: error.response?.data?.message || "Error starting payroll transaction in database.",
      });
    }
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
        basic: 85000,
        hra: 34000,
        lta: 8500,
      },
      deductions: {
        pf: 10200,
        tax: 4300,
      },
    });
    setViewerOpen(true);
  };

  const tabItems = [
    {
      key: "history",
      label: "Payroll Payout Cycles",
      children: isLoading ? <Spin style={{ display: "block", margin: "40px auto" }} /> : <PayrollTable records={records} onViewPayslip={handleOpenViewer} />,
    },
    {
      key: "breakdown",
      label: "Standard Salary Structure",
      children: <SalaryBreakdown />,
    },
  ];

  // Calculate cumulative stats from live records
  const totalPayrollValue = rawRuns
    .filter((r: any) => r.status === "PROCESSED")
    .reduce((sum: number, r: any) => sum + (parseFloat(r.total_payout) || 0), 0);

  const formattedTotalPayout = `₹${totalPayrollValue.toLocaleString("en-IN")}`;

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
              loading={runPayrollMutation.isPending}
              style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
            >
              Run Payroll Cycle
            </Button>
          </Space>
        </Col>
      </Row>

      {/* KPI Section */}
      <PayrollStats
        totalPayout={formattedTotalPayout}
        avgCTC="₹11,64,000 / yr"
        totalDeductions="₹4,55,000"
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
