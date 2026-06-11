import React from "react";
import { Table, Button, Space, Tag } from "antd";
import { DownloadOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

export interface ReportRecord {
  id: string;
  name: string;
  category: "Employee" | "Attendance" | "Leave" | "Recruitment" | "Payroll" | string;
  scope: string;
  createdDate: string;
  fileFormat: "PDF" | "XLSX" | string;
}

interface ReportsTableProps {
  records: ReportRecord[];
  onDownload: (record: ReportRecord) => void;
}

export const ReportsTable: React.FC<ReportsTableProps> = ({
  records,
  onDownload,
}) => {
  const columns: ColumnsType<ReportRecord> = [
    { title: "Report Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
    {
      title: "Category",
      dataIndex: "category",
      key: "category",
      render: (cat: string) => {
        let color = "blue";
        if (cat === "Payroll") color = "purple";
        if (cat === "Attendance") color = "green";
        if (cat === "Leave") color = "orange";
        return <Tag color={color}>{cat}</Tag>;
      },
    },
    { title: "Target Scope", dataIndex: "scope", key: "scope" },
    { title: "Generated Date", dataIndex: "createdDate", key: "createdDate" },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Space>
          <Button size="small" icon={<DownloadOutlined />} onClick={() => onDownload(record)}>
            Download {record.fileFormat}
          </Button>
        </Space>
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
