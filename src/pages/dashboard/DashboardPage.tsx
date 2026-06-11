import React from "react";
import { Row, Col } from "antd";
import {
  TeamOutlined,
  CalendarOutlined,
  DollarOutlined,
  PieChartOutlined,
} from "@ant-design/icons";

import { WelcomeBanner } from "../../components/dashboard/WelcomeBanner";
import { StatsCard } from "../../components/dashboard/StatsCard";
import { QuickActions } from "../../components/dashboard/QuickActions";
import { LeaveRequestsTable } from "../../components/dashboard/LeaveRequestsTable";
import { Celebrations } from "../../components/dashboard/Celebrations";
import { Announcements } from "../../components/dashboard/Announcements";
import { ServerHealth } from "../../components/dashboard/ServerHealth";
import { DashboardCharts } from "../../components/dashboard/DashboardCharts";

const DashboardPage: React.FC = () => {
  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      {/* Personalized banner */}
      <WelcomeBanner />

      {/* KPI metrics row */}
      <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Total Employees"
            value="1,248"
            icon={<TeamOutlined />}
            trend={{ value: 12, isPositive: true }}
            description="Since last quarter"
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Active Leave Today"
            value="14"
            icon={<CalendarOutlined />}
            trend={{ value: 2.4, isPositive: false }}
            description="Absent percentage check"
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Monthly Expenses"
            value="$424,500"
            icon={<DollarOutlined />}
            trend={{ value: 8.5, isPositive: true }}
            description="Gross payroll calculations"
          />
        </Col>
        <Col xs={24} sm={12} xl={6}>
          <StatsCard
            title="Recruitment Openings"
            value="24"
            icon={<PieChartOutlined />}
            trend={{ value: 4, isPositive: true }}
            description="Active roles hiring"
          />
        </Col>
      </Row>

      {/* Chart layouts */}
      <DashboardCharts />

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
