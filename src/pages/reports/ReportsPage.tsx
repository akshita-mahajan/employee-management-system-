import React, { useState } from "react";
import { Tabs, Row, Col, Space, Button, notification } from "antd";
import { DownloadOutlined } from "@ant-design/icons";

import { AnalyticsDashboard } from "../../components/reports/AnalyticsDashboard";
import { ReportsTable } from "../../components/reports/ReportsTable";
import type { ReportRecord } from "../../components/reports/ReportsTable";

const mockReportsList: ReportRecord[] = [
  { id: "1", name: "Workforce_Headcount_Report_Q2", category: "Employee", scope: "Organization-wide", createdDate: "2026-06-10", fileFormat: "PDF" },
  { id: "2", name: "May_Attendance_Audit_Summary", category: "Attendance", scope: "Engineering Department", createdDate: "2026-06-08", fileFormat: "XLSX" },
  { id: "3", name: "Q1_Absence_Rate_Analysis", category: "Leave", scope: "All Departments", createdDate: "2026-06-05", fileFormat: "PDF" },
  { id: "4", name: "Active_Hiring_Funnel_Metrics", category: "Recruitment", scope: "TA Division", createdDate: "2026-06-02", fileFormat: "XLSX" },
  { id: "5", name: "Monthly_Salary_Payout_Details", category: "Payroll", scope: "Finance Division", createdDate: "2026-05-31", fileFormat: "PDF" },
];

const ReportsPage: React.FC = () => {
  const [records] = useState<ReportRecord[]>(mockReportsList);

  const handleDownload = (report: ReportRecord) => {
    notification.success({
      message: "Download Started",
      description: `Downloading report file: ${report.name}.${report.fileFormat.toLowerCase()}`,
    });
  };

  const handleGenerateCustom = () => {
    notification.success({
      message: "Report Job Initialized",
      description: "Custom organization reports task dispatched to pipeline. You will be alerted when complete.",
    });
  };

  const tabItems = [
    {
      key: "analytics",
      label: "Visual Dashboards",
      children: <AnalyticsDashboard />,
    },
    {
      key: "logs",
      label: "Generated Reports Logs",
      children: <ReportsTable records={records} onDownload={handleDownload} />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Reports & Analytics
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Generate custom data reports, analyze departmental breakdowns, and audit workforce records.
          </p>
        </Col>
        <Col>
          <Space>
            <Button
              type="primary"
              icon={<DownloadOutlined />}
              onClick={handleGenerateCustom}
              style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
            >
              Generate Report
            </Button>
          </Space>
        </Col>
      </Row>

      <Tabs defaultActiveKey="analytics" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />
    </div>
  );
};

export default ReportsPage;
