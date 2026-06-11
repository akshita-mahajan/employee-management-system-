import React from "react";
import { Row, Col, Card } from "antd";
import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  BarChart,
  Bar,
  Legend,
} from "recharts";

const monthlyTrendData = [
  { name: "Week 1", rate: 94 },
  { name: "Week 2", rate: 96 },
  { name: "Week 3", rate: 95 },
  { name: "Week 4", rate: 97 },
];

const dailyDistributionData = [
  { name: "Engineering", present: 42, absent: 3 },
  { name: "Product", present: 14, absent: 1 },
  { name: "Marketing", present: 18, absent: 2 },
  { name: "HR", present: 7, absent: 1 },
];

export const AttendanceCharts: React.FC = () => {
  return (
    <Row gutter={[24, 24]} style={{ marginBottom: "24px" }}>
      <Col xs={24} lg={12}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Monthly Attendance Trend (%)</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px", height: "360px" }}
        >
          <div style={{ width: "100%", height: "260px" }}>
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={monthlyTrendData}>
                <defs>
                  <linearGradient id="colorRate" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#0061FF" stopOpacity={0.8} />
                    <stop offset="95%" stopColor="#0061FF" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="name" stroke="#94a3b8" fontSize={12} />
                <YAxis domain={[80, 100]} stroke="#94a3b8" fontSize={12} />
                <Tooltip />
                <Area type="monotone" dataKey="rate" name="Attendance Rate" stroke="#0061FF" fillOpacity={1} fill="url(#colorRate)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </Col>

      <Col xs={24} lg={12}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Daily Presence by Department</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px", height: "360px" }}
        >
          <div style={{ width: "100%", height: "260px" }}>
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={dailyDistributionData}>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="name" stroke="#94a3b8" fontSize={12} />
                <YAxis stroke="#94a3b8" fontSize={12} />
                <Tooltip />
                <Legend />
                <Bar dataKey="present" name="Present Staff" fill="#16a34a" radius={[4, 4, 0, 0]} />
                <Bar dataKey="absent" name="Absent Staff" fill="#ef4444" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>
      </Col>
    </Row>
  );
};
