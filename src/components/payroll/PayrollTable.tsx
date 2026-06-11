import React from "react";
import { Table, Tag, Button } from "antd";
import { EyeOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

export interface PayrollRecord {
  id: string;
  month: string;
  totalPayout: string;
  status: "PROCESSED" | "PENDING" | string;
  employeeCount: number;
}

interface PayrollTableProps {
  records: PayrollRecord[];
  onViewPayslip: (record: PayrollRecord) => void;
}

export const PayrollTable: React.FC<PayrollTableProps> = ({
  records,
  onViewPayslip,
}) => {
  const columns: ColumnsType<PayrollRecord> = [
    { title: "Cycle Month", dataIndex: "month", key: "month", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
    { title: "Total Monthly Payout", dataIndex: "totalPayout", key: "totalPayout" },
    { title: "Staff Payroll Count", dataIndex: "employeeCount", key: "employeeCount" },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => {
        const color = status === "PROCESSED" ? "green" : "orange";
        return (
          <Tag color={color} style={{ fontWeight: 600, borderRadius: "4px" }}>
            {status}
          </Tag>
        );
      },
    },
    {
      title: "Action Details",
      key: "action",
      render: (_, record) => (
        <Button size="small" icon={<EyeOutlined />} onClick={() => onViewPayslip(record)}>
          View Detailed Payslip
        </Button>
      ),
    },
  ];

  return (
    <Table
      columns={columns}
      dataSource={records}
      rowKey="id"
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
    />
  );
};
