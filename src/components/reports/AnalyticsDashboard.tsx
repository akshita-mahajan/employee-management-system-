import React from "react";
import { Row, Col, Card } from "antd";
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

const employeeDistribution = [
  { name: "Engineering", value: 520 },
  { name: "Product", value: 180 },
  { name: "Sales & Marketing", value: 340 },
  { name: "HR & Finance", value: 208 },
];

const COLORS = ["#0061FF", "#60EFFF", "#3b82f6", "#9333ea"];

const payrollTrend = [
  { name: "Jan", payroll: 410000 },
  { name: "Feb", payroll: 412000 },
  { name: "Mar", payroll: 418000 },
  { name: "Apr", payroll: 424500 },
  { name: "May", payroll: 425000 },
];

const attendanceAnalytics = [
  { name: "Mon", attendance: 95 },
  { name: "Tue", attendance: 97 },
  { name: "Wed", attendance: 96 },
  { name: "Thu", attendance: 98 },
  { name: "Fri", attendance: 94 },
];

const recruitmentFunnel = [
  { stage: "Applied", candidates: 450 },
  { stage: "Screened", candidates: 280 },
  { stage: "Interviewed", candidates: 120 },
  { stage: "Offered", candidates: 35 },
  { stage: "Hired", candidates: 24 },
];

export const AnalyticsDashboard: React.FC = () => {
  return (
    <div>
      <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
        {/* Employee Distribution Pie Chart */}
        <Col xs={24} lg={12}>
          <Card title={<span style={{ fontWeight: 600 }}>Employee Distribution by Department</span>} bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <div style={{ width: "100%", height: "280px" }}>
              <ResponsiveContainer width="100%" height="100%">
                <PieChart>
                  <Pie data={employeeDistribution} cx="50%" cy="50%" innerRadius={60} outerRadius={80} paddingAngle={5} dataKey="value">
                    {employeeDistribution.map((_, index) => (
                      <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                    ))}
                  </Pie>
                  <Tooltip />
                  <Legend />
                </PieChart>
              </ResponsiveContainer>
            </div>
          </Card>
        </Col>

        {/* Monthly Payroll Expenses Bar Chart */}
        <Col xs={24} lg={12}>
          <Card title={<span style={{ fontWeight: 600 }}>Monthly Payroll Expense Trend ($)</span>} bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <div style={{ width: "100%", height: "280px" }}>
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={payrollTrend}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} />
                  <XAxis dataKey="name" stroke="#94a3b8" />
                  <YAxis stroke="#94a3b8" />
                  <Tooltip />
                  <Bar dataKey="payroll" name="Total Payout" fill="#0061FF" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </Card>
        </Col>
      </Row>

      <Row gutter={[24, 24]}>
        {/* Attendance Rates Line Chart */}
        <Col xs={24} lg={12}>
          <Card title={<span style={{ fontWeight: 600 }}>Weekly Attendance Rates (%)</span>} bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <div style={{ width: "100%", height: "280px" }}>
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={attendanceAnalytics}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} />
                  <XAxis dataKey="name" stroke="#94a3b8" />
                  <YAxis domain={[80, 100]} stroke="#94a3b8" />
                  <Tooltip />
                  <Line type="monotone" dataKey="attendance" name="Attendance Rate" stroke="#16a34a" strokeWidth={3} activeDot={{ r: 8 }} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </Card>
        </Col>

        {/* Recruitment Pipeline Area Chart */}
        <Col xs={24} lg={12}>
          <Card title={<span style={{ fontWeight: 600 }}>Active Recruitment Funnel</span>} bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <div style={{ width: "100%", height: "280px" }}>
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={recruitmentFunnel}>
                  <defs>
                    <linearGradient id="colorCandidates" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#9333ea" stopOpacity={0.8} />
                      <stop offset="95%" stopColor="#9333ea" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} />
                  <XAxis dataKey="stage" stroke="#94a3b8" />
                  <YAxis stroke="#94a3b8" />
                  <Tooltip />
                  <Area type="monotone" dataKey="candidates" name="Candidates count" stroke="#9333ea" fillOpacity={1} fill="url(#colorCandidates)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </Card>
        </Col>
      </Row>
    </div>
  );
};
