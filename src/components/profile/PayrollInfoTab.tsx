import React from "react";
import { Card, Row, Col, Statistic, Table, Button } from "antd";
import { DownloadOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

interface PayslipRecord {
  key: string;
  month: string;
  baseSalary: string;
  allowances: string;
  netPay: string;
}

const mockPayslips: PayslipRecord[] = [
  { key: "1", month: "May 2026", baseSalary: "$8,500", allowances: "$1,200", netPay: "$9,700" },
  { key: "2", month: "April 2026", baseSalary: "$8,500", allowances: "$1,200", netPay: "$9,700" },
  { key: "3", month: "March 2026", baseSalary: "$8,500", allowances: "$950", netPay: "$9,450" },
];

export const PayrollInfoTab: React.FC = () => {
  const columns: ColumnsType<PayslipRecord> = [
    { title: "Cycle Month", dataIndex: "month", key: "month" },
    { title: "Base Salary", dataIndex: "baseSalary", key: "baseSalary" },
    { title: "Allowances", dataIndex: "allowances", key: "allowances" },
    { title: "Net Salary Paid", dataIndex: "netPay", key: "netPay", render: (text) => <span style={{ fontWeight: 600, color: "#16a34a" }}>{text}</span> },
    {
      title: "Actions",
      key: "actions",
      render: () => <Button size="small" icon={<DownloadOutlined />}>PDF</Button>,
    },
  ];

  return (
    <div>
      <Row gutter={[16, 16]} style={{ marginBottom: "24px" }}>
        <Col span={8}>
          <Card style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <Statistic title="Base Monthly" value={8500} prefix="$" precision={2} />
          </Card>
        </Col>
        <Col span={8}>
          <Card style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <Statistic title="Annual CTC" value={116400} prefix="$" precision={2} />
          </Card>
        </Col>
        <Col span={8}>
          <Card style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
            <Statistic title="Deductions (Tax/PF)" value={1450} prefix="$" precision={2} />
          </Card>
        </Col>
      </Row>

      <Card
        title={<span style={{ fontWeight: 600 }}>Payslip Documents History</span>}
        bordered={false}
        style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
      >
        <Table columns={columns} dataSource={mockPayslips} pagination={false} />
      </Card>
    </div>
  );
};
