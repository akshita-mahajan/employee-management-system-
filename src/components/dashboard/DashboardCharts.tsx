import React from "react";
import { Card, Row, Col } from "antd";
import {
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
  Tooltip,
  Legend,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  BarChart,
  Bar,
} from "recharts";

const departmentData = [
  { name: "Engineering", value: 45 },
  { name: "Sales & Marketing", value: 30 },
  { name: "Operations", value: 15 },
  { name: "HR & Legal", value: 10 },
];

const COLORS = ["#0061FF", "#60EFFF", "#3b82f6", "#9333ea"];

const attendanceData = [
  { name: "Mon", attendance: 96 },
  { name: "Tue", attendance: 98 },
  { name: "Wed", attendance: 97 },
  { name: "Thu", attendance: 95 },
  { name: "Fri", attendance: 93 },
];

const budgetData = [
  { name: "Q1", budget: 120000, actual: 115000 },
  { name: "Q2", budget: 150000, actual: 162000 },
  { name: "Q3", budget: 180000, actual: 175000 },
  { name: "Q4", budget: 200000, actual: 195000 },
];

export const DashboardCharts: React.FC = () => {
  return (
    <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
      {/* Employee Distribution Pie Chart */}
      <Col xs={24} lg={8}>
        <Card
          title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Employee Distribution</span>}
          bordered={false}
          style={{
            borderRadius: "8px",
            boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
            border: "1px solid #e2e8f0",
            height: "360px",
          }}
        >
          <div style={{ width: "100%", height: "260px" }}>
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={departmentData}
                  cx="50%"
                  cy="50%"
                  innerRadius={60}
                  outerRadius={80}
                  paddingAngle={5}
                  dataKey="value"
                >
                  {departmentData.map((_, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip />
                <Legend layout="horizontal" verticalAlign="bottom" align="center" iconSize={8} />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </Col>

      {/* Attendance Trends Area Chart */}
      <Col xs={24} lg={8}>
        <Card
          title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Attendance Trends</span>}
          bordered={false}
          style={{
            borderRadius: "8px",
            boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
            border: "1px solid #e2e8f0",
            height: "360px",
          }}
        >
          <div style={{ width: "100%", height: "260px" }}>
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={attendanceData}>
                <defs>
                  <linearGradient id="colorAttendance" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#0061FF" stopOpacity={0.8} />
                    <stop offset="95%" stopColor="#0061FF" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="name" stroke="#94a3b8" fontSize={12} />
                <YAxis domain={[80, 100]} stroke="#94a3b8" fontSize={12} />
                <Tooltip />
                <Area type="monotone" dataKey="attendance" stroke="#0061FF" fillOpacity={1} fill="url(#colorAttendance)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </Col>

      {/* Budget Allocation Bar Chart */}
      <Col xs={24} lg={8}>
        <Card
          title={<span style={{ fontWeight: 600, fontSize: "16px", color: "#1e293b" }}>Payroll & Operations</span>}
          bordered={false}
          style={{
            borderRadius: "8px",
            boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
            border: "1px solid #e2e8f0",
            height: "360px",
          }}
        >
          <div style={{ width: "100%", height: "260px" }}>
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={budgetData}>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="name" stroke="#94a3b8" fontSize={12} />
                <YAxis stroke="#94a3b8" fontSize={12} />
                <Tooltip />
                <Legend />
                <Bar dataKey="budget" fill="#0061FF" radius={[4, 4, 0, 0]} />
                <Bar dataKey="actual" fill="#60EFFF" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </Col>
    </Row>
  );
};
