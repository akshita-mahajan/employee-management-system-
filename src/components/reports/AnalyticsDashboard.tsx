import React from "react";
import { Row, Col, Card, Spin, Empty } from "antd";
import {
  ResponsiveContainer,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  PieChart,
  Pie,
  Cell,
  LineChart,
  Line,
  AreaChart,
  Area,
} from "recharts";

interface AnalyticsDashboardProps {
  employeeData: any;
  payrollData: any;
  attendanceData: any;
  loading: boolean;
}

const COLORS = ["#0061FF", "#3b82f6", "#9333ea", "#16a34a", "#f59e0b", "#ef4444"];

export const AnalyticsDashboard: React.FC<AnalyticsDashboardProps> = ({
  employeeData,
  payrollData,
  attendanceData,
  loading,
}) => {
  if (loading) {
    return (
      <div style={{ textAlign: "center", padding: "100px 0" }}>
        <Spin size="large" tip="Aggregating live PostgreSQL records..." />
      </div>
    );
  }

  const deptDistribution = employeeData?.departmentDistribution || [];
  const payrollTrend = payrollData?.payrollTrend || [];
  const attendanceTrend = attendanceData?.attendanceTrend || [];
  const statusDistribution = employeeData?.statusDistribution || [];

  const hasData = deptDistribution.length > 0 || payrollTrend.length > 0 || attendanceTrend.length > 0 || statusDistribution.length > 0;

  if (!hasData) {
    return (
      <div style={{ padding: "50px 0" }}>
        <Empty description="No aggregated metrics found for the selected filter criteria." />
      </div>
    );
  }

  return (
    <div>
      <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
        {/* Employee Distribution Pie Chart */}
        <Col xs={24} lg={12}>
          <Card 
            title={<span style={{ fontWeight: 600 }}>Employee Distribution by Department</span>} 
            bordered={false} 
            style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
          >
            <div style={{ width: "100%", height: "280px" }}>
              {deptDistribution.length === 0 ? (
                <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="No department statistics" />
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie 
                      data={deptDistribution} 
                      cx="50%" 
                      cy="50%" 
                      innerRadius={60} 
                      outerRadius={80} 
                      paddingAngle={5} 
                      dataKey="value"
                    >
                      {deptDistribution.map((_: any, index: number) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip formatter={(value) => [`${value} Employees`, "Headcount"]} />
                    <Legend />
                  </PieChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>

        {/* Monthly Payroll Expenses Bar Chart */}
        <Col xs={24} lg={12}>
          <Card 
            title={<span style={{ fontWeight: 600 }}>Monthly Payroll Expense Trend (₹)</span>} 
            bordered={false} 
            style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
          >
            <div style={{ width: "100%", height: "280px" }}>
              {payrollTrend.length === 0 ? (
                <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="No payroll records" />
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={payrollTrend}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="month" stroke="#94a3b8" />
                    <YAxis 
                      stroke="#94a3b8" 
                      tickFormatter={(val) => `₹${(val / 1000).toFixed(0)}k`} 
                    />
                    <Tooltip formatter={(value) => [`₹${Number(value).toLocaleString()}`, "Actual Paid"]} />
                    <Legend />
                    <Bar dataKey="actual_paid" name="Total Payout" fill="#0061FF" radius={[4, 4, 0, 0]} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>
      </Row>

      <Row gutter={[24, 24]}>
        {/* Attendance Rates Line Chart */}
        <Col xs={24} lg={12}>
          <Card 
            title={<span style={{ fontWeight: 600 }}>Weekly Attendance Rates (%)</span>} 
            bordered={false} 
            style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
          >
            <div style={{ width: "100%", height: "280px" }}>
              {attendanceTrend.length === 0 ? (
                <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="No attendance metrics logs" />
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={attendanceTrend}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" stroke="#94a3b8" />
                    <YAxis domain={[0, 100]} stroke="#94a3b8" />
                    <Tooltip formatter={(value) => [`${value}%`, "Attendance Rate"]} />
                    <Legend />
                    <Line 
                      type="monotone" 
                      dataKey="attendance" 
                      name="Attendance Rate" 
                      stroke="#16a34a" 
                      strokeWidth={3} 
                      activeDot={{ r: 8 }} 
                    />
                  </LineChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>

        {/* Workforce Status Distribution Area Chart */}
        <Col xs={24} lg={12}>
          <Card 
            title={<span style={{ fontWeight: 600 }}>Workforce Status Allocation</span>} 
            bordered={false} 
            style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
          >
            <div style={{ width: "100%", height: "280px" }}>
              {statusDistribution.length === 0 ? (
                <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="No status records" />
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <AreaChart data={statusDistribution}>
                    <defs>
                      <linearGradient id="colorStatus" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#9333ea" stopOpacity={0.8} />
                        <stop offset="95%" stopColor="#9333ea" stopOpacity={0} />
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" stroke="#94a3b8" />
                    <YAxis stroke="#94a3b8" />
                    <Tooltip formatter={(value) => [`${value} Employees`, "Headcount"]} />
                    <Legend />
                    <Area 
                      type="monotone" 
                      dataKey="value" 
                      name="Total Staff" 
                      stroke="#9333ea" 
                      fillOpacity={1} 
                      fill="url(#colorStatus)" 
                    />
                  </AreaChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>
      </Row>
    </div>
  );
};
