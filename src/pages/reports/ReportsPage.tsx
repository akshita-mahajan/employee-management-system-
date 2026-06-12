import React, { useState } from "react";
import { Tabs, Row, Col, Space, Button, notification, Select, Card, Statistic, Modal, Form, Input } from "antd";
import { DownloadOutlined, PlusOutlined, UserOutlined, WalletOutlined, CalendarOutlined } from "@ant-design/icons";

import { AnalyticsDashboard } from "../../components/reports/AnalyticsDashboard";
import { ReportsTable } from "../../components/reports/ReportsTable";
import type { ReportRecord } from "../../components/reports/ReportsTable";
import { 
  useReportDashboard, 
  useReportEmployees, 
  useReportPayroll, 
  useReportAttendance, 
  useGenerateReport,
  useDepartments,
  useTeams
} from "../../hooks/useHRMS";

const { Option } = Select;

const ReportsPage: React.FC = () => {
  const [activeTab, setActiveTab] = useState("analytics");
  const [modalOpen, setModalOpen] = useState(false);
  const [form] = Form.useForm();

  // 1. BI Filter States
  const [departmentId, setDepartmentId] = useState<string | undefined>(undefined);
  const [teamId, setTeamId] = useState<string | undefined>(undefined);
  const [year, setYear] = useState<string | undefined>(undefined);
  const [status, setStatus] = useState<string | undefined>(undefined);

  const filterParams = { departmentId, teamId, year, status };

  // 2. Fetch live reporting data
  const { data: depts = [] } = useDepartments();
  const { data: teams = [] } = useTeams();

  const { data: dashboardData, isLoading: dashboardLoading, refetch: refetchDashboard } = useReportDashboard();
  const { data: employeeData, isLoading: empLoading, refetch: refetchEmployees } = useReportEmployees(filterParams);
  const { data: payrollData, isLoading: payLoading, refetch: refetchPayroll } = useReportPayroll(filterParams);
  const { data: attendanceData, isLoading: attLoading, refetch: refetchAttendance } = useReportAttendance(filterParams);

  const generateReportMutation = useGenerateReport();

  const kpis = dashboardData?.kpis || { totalEmployees: 0, totalPayroll: 0, attendanceRate: 0 };
  const reportRecords: ReportRecord[] = dashboardData?.reportsList || [];

  const handleDownload = (report: ReportRecord) => {
    notification.success({
      message: "Download Triggered",
      description: `Exporting filtered data for ${report.name}.${report.fileFormat.toLowerCase()}`,
    });
  };

  const handleGenerateCustom = async (values: any) => {
    try {
      await generateReportMutation.mutateAsync({
        name: values.name,
        category: values.category,
        fileFormat: values.fileFormat,
        scope: values.scope || "Filtered Workspace",
      });
      notification.success({
        message: "Report Created",
        description: `Successfully logged new database export: ${values.name}`,
      });
      setModalOpen(false);
      form.resetFields();
      refetchDashboard();
    } catch (error) {
      notification.error({
        message: "Generation Failed",
        description: "Error inserting report log into PostgreSQL database.",
      });
    }
  };

  const clearFilters = () => {
    setDepartmentId(undefined);
    setTeamId(undefined);
    setYear(undefined);
    setStatus(undefined);
  };

  const tabItems = [
    {
      key: "analytics",
      label: "Visual BI Dashboards",
      children: (
        <AnalyticsDashboard 
          employeeData={employeeData}
          payrollData={payrollData}
          attendanceData={attendanceData}
          loading={empLoading || payLoading || attLoading}
        />
      ),
    },
    {
      key: "logs",
      label: "Generated Reports Logs",
      children: (
        <ReportsTable 
          records={reportRecords} 
          onDownload={handleDownload} 
          loading={dashboardLoading}
        />
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      {/* Page Header */}
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Reports & Business Intelligence
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Query PostgreSQL data aggregates, check operational KPIs, and compile custom compliance logs.
          </p>
        </Col>
        <Col>
          <Space>
            <Button
              type="primary"
              icon={<PlusOutlined />}
              onClick={() => setModalOpen(true)}
              style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
            >
              Generate Report
            </Button>
          </Space>
        </Col>
      </Row>

      {/* Live KPIs Grid */}
      <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
        <Col xs={24} sm={8}>
          <Card bordered={false} style={{ borderRadius: "12px", border: "1px solid #e2e8f0" }}>
            <Statistic
              title="Active Headcount"
              value={kpis.totalEmployees}
              prefix={<UserOutlined style={{ color: "#0061FF" }} />}
              valueStyle={{ fontWeight: 700, color: "#0f172a" }}
            />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card bordered={false} style={{ borderRadius: "12px", border: "1px solid #e2e8f0" }}>
            <Statistic
              title="Total Payroll Disbursed"
              value={kpis.totalPayroll}
              prefix={<WalletOutlined style={{ color: "#9333ea" }} />}
              precision={2}
              formatter={(value) => `₹${value.toLocaleString()}`}
              valueStyle={{ fontWeight: 700, color: "#0f172a" }}
            />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card bordered={false} style={{ borderRadius: "12px", border: "1px solid #e2e8f0" }}>
            <Statistic
              title="Overall Attendance Rate"
              value={kpis.attendanceRate}
              prefix={<CalendarOutlined style={{ color: "#16a34a" }} />}
              suffix="%"
              valueStyle={{ fontWeight: 700, color: "#0f172a" }}
            />
          </Card>
        </Col>
      </Row>

      {/* Reports BI Filters Row */}
      <Card bordered={false} style={{ marginBottom: "24px", borderRadius: "12px", border: "1px solid #e2e8f0" }}>
        <Row gutter={[16, 16]} align="middle">
          <Col xs={24} sm={6} md={5}>
            <span style={{ fontWeight: 600, color: "#475569", display: "block", marginBottom: "4px" }}>Department</span>
            <Select
              style={{ width: "100%" }}
              placeholder="All Departments"
              allowClear
              value={departmentId}
              onChange={(value) => setDepartmentId(value)}
            >
              {depts.map((d: any) => (
                <Option key={d.id} value={d.id}>{d.name}</Option>
              ))}
            </Select>
          </Col>
          <Col xs={24} sm={6} md={5}>
            <span style={{ fontWeight: 600, color: "#475569", display: "block", marginBottom: "4px" }}>Team</span>
            <Select
              style={{ width: "100%" }}
              placeholder="All Teams"
              allowClear
              value={teamId}
              onChange={(value) => setTeamId(value)}
            >
              {teams.map((t: any) => (
                <Option key={t.id} value={t.id}>{t.name}</Option>
              ))}
            </Select>
          </Col>
          <Col xs={24} sm={6} md={5}>
            <span style={{ fontWeight: 600, color: "#475569", display: "block", marginBottom: "4px" }}>Year</span>
            <Select
              style={{ width: "100%" }}
              placeholder="Select Year"
              allowClear
              value={year}
              onChange={(value) => setYear(value)}
            >
              <Option value="2026">2026</Option>
              <Option value="2025">2025</Option>
            </Select>
          </Col>
          <Col xs={24} sm={6} md={5}>
            <span style={{ fontWeight: 600, color: "#475569", display: "block", marginBottom: "4px" }}>Status</span>
            <Select
              style={{ width: "100%" }}
              placeholder="All Statuses"
              allowClear
              value={status}
              onChange={(value) => setStatus(value)}
            >
              <Option value="ACTIVE">Active</Option>
              <Option value="INACTIVE">Inactive</Option>
              <Option value="ON_LEAVE">On Leave</Option>
              <Option value="TERMINATED">Terminated</Option>
            </Select>
          </Col>
          <Col xs={24} sm={24} md={4} style={{ textAlign: "right", paddingTop: "20px" }}>
            <Button onClick={clearFilters} type="default" style={{ borderRadius: "6px", width: "100%" }}>
              Reset Filters
            </Button>
          </Col>
        </Row>
      </Card>

      <Tabs 
        activeKey={activeTab} 
        onChange={setActiveTab}
        items={tabItems} 
        style={{ background: "#ffffff", padding: "20px", borderRadius: "12px", border: "1px solid #e2e8f0" }} 
      />

      {/* Generate Custom Report Modal */}
      <Modal
        title="Generate & Save Custom Workspace Report"
        open={modalOpen}
        onCancel={() => setModalOpen(false)}
        onOk={() => form.submit()}
        okText="Generate Report Log"
        destroyOnClose
      >
        <Form form={form} layout="vertical" onFinish={handleGenerateCustom}>
          <Form.Item
            name="name"
            label="Report Title"
            rules={[{ required: true, message: "Please input the report title!" }]}
          >
            <Input placeholder="e.g. Q2_Engineering_Headcount_Report" />
          </Form.Item>
          <Form.Item
            name="category"
            label="Category"
            rules={[{ required: true, message: "Please select a category!" }]}
          >
            <Select placeholder="Select reporting category">
              <Option value="Employee">Employee Data</Option>
              <Option value="Attendance">Attendance Logs</Option>
              <Option value="Leave">Leaves Tracker</Option>
              <Option value="Payroll">Payroll Audits</Option>
            </Select>
          </Form.Item>
          <Form.Item
            name="fileFormat"
            label="Format"
            rules={[{ required: true, message: "Please select the file format!" }]}
          >
            <Select placeholder="Select output format">
              <Option value="PDF">PDF Document</Option>
              <Option value="XLSX">Excel Spreadsheet</Option>
            </Select>
          </Form.Item>
          <Form.Item
            name="scope"
            label="Target Scope"
            initialValue="Filtered Workspace"
          >
            <Input placeholder="e.g. Engineering Division" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default ReportsPage;
