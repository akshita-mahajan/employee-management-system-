import React, { useState } from "react";
import { Row, Col, Select, Card, Space, Button } from "antd";
import {
  TeamOutlined,
  CalendarOutlined,
  DollarOutlined,
  LineChartOutlined,
  ReloadOutlined
} from "@ant-design/icons";

import { WelcomeBanner } from "../../components/dashboard/WelcomeBanner";
import { StatsCard } from "../../components/dashboard/StatsCard";
import { QuickActions } from "../../components/dashboard/QuickActions";
import { LeaveRequestsTable } from "../../components/dashboard/LeaveRequestsTable";
import { Celebrations } from "../../components/dashboard/Celebrations";
import { Announcements } from "../../components/dashboard/Announcements";
import { ServerHealth } from "../../components/dashboard/ServerHealth";
import { DashboardCharts } from "../../components/dashboard/DashboardCharts";
import { useDashboardAnalytics, useDepartments } from "../../hooks/useHRMS";

const DashboardPage: React.FC = () => {
  // Global filter states
  const [selectedDeptId, setSelectedDeptId] = useState<string>("");
  const [selectedYear, setSelectedYear] = useState<string>("2026");
  const [selectedQuarter, setSelectedQuarter] = useState<string>("");

  const { data: depts = [] } = useDepartments();
  const { data: analytics, isLoading, refetch } = useDashboardAnalytics({
    departmentId: selectedDeptId || undefined,
    year: selectedYear || undefined,
    quarter: selectedQuarter || undefined,
  });

  const kpis = analytics?.kpis || {
    totalEmployees: { value: 0, growth: 0 },
    totalPayroll: { value: 0, growth: 0 },
    attendanceRate: { value: 0, growth: 0 }
  };

  const formattedPayroll = `₹${(kpis.totalPayroll.value || 0).toLocaleString("en-IN")}`;

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      {/* Personalized banner */}
      <WelcomeBanner />

      {/* Global Analytics Filters */}
      <Card 
        bordered={false} 
        style={{ 
          marginBottom: "24px", 
          borderRadius: "8px", 
          boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
          border: "1px solid rgba(0,0,0,0.05)"
        }}
      >
        <Row justify="space-between" align="middle" gutter={[16, 16]}>
          <Col xs={24} sm={8}>
            <span style={{ fontWeight: 600, fontSize: "14px", marginRight: "12px" }}>Analytics Filters:</span>
            <Button size="small" type="text" icon={<ReloadOutlined />} onClick={() => refetch()}>Refresh</Button>
          </Col>
          <Col xs={24} sm={16} style={{ textAlign: "right" }}>
            <Space wrap>
              <Select
                placeholder="All Departments"
                value={selectedDeptId || undefined}
                onChange={setSelectedDeptId}
                allowClear
                style={{ width: 180 }}
                options={depts.map((d: any) => ({ value: d.id, label: d.name }))}
              />
              <Select
                placeholder="Quarter"
                value={selectedQuarter || undefined}
                onChange={setSelectedQuarter}
                allowClear
                style={{ width: 120 }}
                options={[
                  { value: "Q1", label: "Q1 Jan-Mar" },
                  { value: "Q2", label: "Q2 Apr-Jun" },
                  { value: "Q3", label: "Q3 Jul-Sep" },
                  { value: "Q4", label: "Q4 Oct-Dec" },
                ]}
              />
              <Select
                placeholder="Year"
                value={selectedYear}
                onChange={setSelectedYear}
                style={{ width: 100 }}
                options={[
                  { value: "2024", label: "2024" },
                  { value: "2025", label: "2025" },
                  { value: "2026", label: "2026" },
                ]}
              />
            </Space>
          </Col>
        </Row>
      </Card>

      {/* KPI metrics row */}
      <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Total Employees"
            value={kpis.totalEmployees.value.toString()}
            icon={<TeamOutlined />}
            trend={{ value: Math.abs(kpis.totalEmployees.growth), isPositive: kpis.totalEmployees.growth >= 0 }}
            description={`${kpis.totalEmployees.growth >= 0 ? "Increase" : "Decrease"} this month`}
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Monthly Expense"
            value={formattedPayroll}
            icon={<DollarOutlined />}
            trend={{ value: Math.abs(kpis.totalPayroll.growth), isPositive: kpis.totalPayroll.growth >= 0 }}
            description="Active payroll payout"
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Attendance Rate"
            value={`${kpis.attendanceRate.value}%`}
            icon={<CalendarOutlined />}
            trend={{ value: Math.abs(kpis.attendanceRate.growth), isPositive: kpis.attendanceRate.growth >= 0 }}
            description="Monthly average presence"
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="HR Openings"
            value="3"
            icon={<LineChartOutlined />}
            trend={{ value: 0, isPositive: true }}
            description="Active recruitment roles"
          />
        </Col>
      </Row>

      {/* Dynamic business intelligence charts */}
      <DashboardCharts analytics={analytics} loading={isLoading} />

      {/* Content grids */}
      <Row gutter={[24, 24]}>
        <Col xs={24} lg={16}>
          <div style={{ display: "flex", flexDirection: "column", gap: "24px" }}>
            <LeaveRequestsTable />
          </div>
        </Col>
        <Col xs={24} lg={8}>
          <div style={{ display: "flex", flexDirection: "column", gap: "24px" }}>
            <QuickActions />
            <Announcements />
            <Celebrations />
            <ServerHealth />
          </div>
        </Col>
      </Row>
    </div>
  );
};

export default DashboardPage;
