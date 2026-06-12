import React from "react";
import { Card, Row, Col, Spin } from "antd";
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

interface DashboardChartsProps {
  analytics?: {
    payrollTrend?: any[];
    departments?: any[];
    salaryDistribution?: {
      bracket_low: number;
      bracket_mid: number;
      bracket_high: number;
      bracket_exec: number;
    };
    workforceGrowth?: any[];
  };
  loading?: boolean;
}

const COLORS = ["#0061FF", "#4A00E0", "#52c41a", "#faad14"];

export const DashboardCharts: React.FC<DashboardChartsProps> = ({ analytics, loading }) => {
  if (loading) {
    return (
      <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "300px", marginBottom: "24px" }}>
        <Spin size="large" tip="Loading HR Intelligence Reports..." />
      </div>
    );
  }

  // Fallbacks for empty states
  const payrollTrend = analytics?.payrollTrend || [];
  const departments = analytics?.departments || [];
  const workforceGrowth = analytics?.workforceGrowth || [];
  
  // Format salary bracket values for Pie Chart
  const salaryDist = analytics?.salaryDistribution || { bracket_low: 0, bracket_mid: 0, bracket_high: 0, bracket_exec: 0 };
  const salaryPieData = [
    { name: "< ₹30k (Junior)", value: salaryDist.bracket_low },
    { name: "₹30k - ₹70k (Mid)", value: salaryDist.bracket_mid },
    { name: "₹70k - ₹1.5L (Senior)", value: salaryDist.bracket_high },
    { name: "> ₹1.5L (Exec)", value: salaryDist.bracket_exec },
  ].filter(d => d.value > 0);

  return (
    <div style={{ marginBottom: "24px" }}>
      <Row gutter={[24, 24]}>
        {/* 1. Monthly Payroll Payout Trend (Budget vs Actual) */}
        <Col xs={24} lg={16}>
          <Card
            title={
              <div>
                <span style={{ fontWeight: 700, fontSize: "16px" }}>Monthly Payroll Expense Trend</span>
                <div style={{ fontSize: "12px", opacity: 0.6, fontWeight: 400 }}>Actual monthly paid vs yearly allocated budget metrics</div>
              </div>
            }
            bordered={false}
            style={{
              borderRadius: "8px",
              boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
              border: "1px solid rgba(0,0,0,0.05)",
              height: "400px",
            }}
          >
            <div style={{ width: "100%", height: "300px" }}>
              {payrollTrend.length === 0 ? (
                <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100%", opacity: 0.5 }}>No payroll history available</div>
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={payrollTrend}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} opacity={0.2} />
                    <XAxis dataKey="month" fontSize={11} />
                    <YAxis fontSize={11} tickFormatter={(val) => `₹${(val / 100000).toFixed(1)}L`} />
                    <Tooltip 
                      formatter={(value) => [`₹${parseFloat(value as string).toLocaleString("en-IN")}`]} 
                      contentStyle={{ borderRadius: "6px" }}
                    />
                    <Legend />
                    <Bar name="Allocated Budget" dataKey="total_budget" fill="#4A00E0" radius={[4, 4, 0, 0]} maxBarSize={40} />
                    <Bar name="Actual Paid" dataKey="actual_paid" fill="#0061FF" radius={[4, 4, 0, 0]} maxBarSize={40} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>

        {/* 2. Salary distribution breakdown */}
        <Col xs={24} lg={8}>
          <Card
            title={
              <div>
                <span style={{ fontWeight: 700, fontSize: "16px" }}>Salary Distribution</span>
                <div style={{ fontSize: "12px", opacity: 0.6, fontWeight: 400 }}>Employee counts grouped by monthly salary bracket</div>
              </div>
            }
            bordered={false}
            style={{
              borderRadius: "8px",
              boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
              border: "1px solid rgba(0,0,0,0.05)",
              height: "400px",
            }}
          >
            <div style={{ width: "100%", height: "300px" }}>
              {salaryPieData.length === 0 ? (
                <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100%", opacity: 0.5 }}>No salary records seeded</div>
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={salaryPieData}
                      cx="50%"
                      cy="50%"
                      innerRadius={60}
                      outerRadius={85}
                      paddingAngle={5}
                      dataKey="value"
                      label={({ value }) => `${value} Staff`}
                    >
                      {salaryPieData.map((_, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip formatter={(value) => [`${value} Employees`]} />
                    <Legend layout="horizontal" verticalAlign="bottom" align="center" iconSize={8} />
                  </PieChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>
      </Row>

      <Row gutter={[24, 24]} style={{ marginTop: "24px" }}>
        {/* 3. Department distribution details */}
        <Col xs={24} lg={12}>
          <Card
            title={
              <div>
                <span style={{ fontWeight: 700, fontSize: "16px" }}>Department Workforce Distribution</span>
                <div style={{ fontSize: "12px", opacity: 0.6, fontWeight: 400 }}>Headcounts, average salary, and budget allocations per department</div>
              </div>
            }
            bordered={false}
            style={{
              borderRadius: "8px",
              boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
              border: "1px solid rgba(0,0,0,0.05)",
              height: "400px",
            }}
          >
            <div style={{ width: "100%", height: "300px" }}>
              {departments.length === 0 ? (
                <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100%", opacity: 0.5 }}>No active departments found</div>
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={departments} layout="vertical" margin={{ left: 20, right: 20 }}>
                    <CartesianGrid strokeDasharray="3 3" horizontal={false} opacity={0.2} />
                    <XAxis type="number" fontSize={11} />
                    <YAxis dataKey="code" type="category" fontSize={11} />
                    <Tooltip 
                      formatter={(value, name) => [
                        name === "avg_salary" ? `₹${parseFloat(value as string).toLocaleString("en-IN")}` : value, 
                        name === "avg_salary" ? "Avg Monthly Salary" : "Staff Size"
                      ]} 
                    />
                    <Legend />
                    <Bar name="Staff Size" dataKey="employee_count" fill="#0061FF" radius={[0, 4, 4, 0]} barSize={20} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </div>
          </Card>
        </Col>

        {/* 4. Workforce Growth Trends */}
        <Col xs={24} lg={12}>
          <Card
            title={
              <div>
                <span style={{ fontWeight: 700, fontSize: "16px" }}>Workforce Growth Trends</span>
                <div style={{ fontSize: "12px", opacity: 0.6, fontWeight: 400 }}>New hires registered in the database per month</div>
              </div>
            }
            bordered={false}
            style={{
              borderRadius: "8px",
              boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
              border: "1px solid rgba(0,0,0,0.05)",
              height: "400px",
            }}
          >
            <div style={{ width: "100%", height: "300px" }}>
              {workforceGrowth.length === 0 ? (
                <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100%", opacity: 0.5 }}>No growth records available</div>
              ) : (
                <ResponsiveContainer width="100%" height="100%">
                  <AreaChart data={workforceGrowth}>
                    <defs>
                      <linearGradient id="colorHires" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#52c41a" stopOpacity={0.8} />
                        <stop offset="95%" stopColor="#52c41a" stopOpacity={0} />
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} opacity={0.2} />
                    <XAxis dataKey="month" fontSize={11} />
                    <YAxis fontSize={11} />
                    <Tooltip contentStyle={{ borderRadius: "6px" }} />
                    <Area type="monotone" name="New Hires" dataKey="new_hires" stroke="#52c41a" fillOpacity={1} fill="url(#colorHires)" />
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
