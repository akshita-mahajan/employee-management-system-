import React from "react";
import { Modal, Descriptions, Divider, Button } from "antd";
import { DownloadOutlined } from "@ant-design/icons";

interface PayslipViewerProps {
  open: boolean;
  onCancel: () => void;
  payslip: {
    month: string;
    employeeName: string;
    employeeId: string;
    designation: string;
    department: string;
    earnings: {
      basic: number;
      hra: number;
      lta: number;
    };
    deductions: {
      pf: number;
      tax: number;
    };
  } | null;
}

export const PayslipViewer: React.FC<PayslipViewerProps> = ({
  open,
  onCancel,
  payslip,
}) => {
  if (!payslip) return null;

  const totalEarnings = payslip.earnings.basic + payslip.earnings.hra + payslip.earnings.lta;
  const totalDeductions = payslip.deductions.pf + payslip.deductions.tax;
  const netPay = totalEarnings - totalDeductions;

  return (
    <Modal
      title={<span style={{ fontWeight: 700, fontSize: "18px" }}>Payslip for {payslip.month}</span>}
      open={open}
      onCancel={onCancel}
      footer={[
        <Button key="download" type="primary" icon={<DownloadOutlined />} style={{ backgroundColor: "#0061FF" }}>
          Download PDF
        </Button>,
      ]}
      width={640}
    >
      <div style={{ padding: "10px 0" }}>
        <Descriptions title="Employee Details" column={2} bordered size="small">
          <Descriptions.Item label="Name">{payslip.employeeName}</Descriptions.Item>
          <Descriptions.Item label="Employee ID">{payslip.employeeId}</Descriptions.Item>
          <Descriptions.Item label="Designation">{payslip.designation}</Descriptions.Item>
          <Descriptions.Item label="Department">{payslip.department}</Descriptions.Item>
        </Descriptions>

        <Divider style={{ margin: "20px 0" }} />

        <Descriptions title="Salary Breakdown" column={2} bordered size="small">
          <Descriptions.Item label="Basic Salary">₹{payslip.earnings.basic.toLocaleString('en-IN')}</Descriptions.Item>
          <Descriptions.Item label="PF Contribution">₹{payslip.deductions.pf.toLocaleString('en-IN')}</Descriptions.Item>
          <Descriptions.Item label="House Rent Allowance (HRA)">₹{payslip.earnings.hra.toLocaleString('en-IN')}</Descriptions.Item>
          <Descriptions.Item label="Income Tax">₹{payslip.deductions.tax.toLocaleString('en-IN')}</Descriptions.Item>
          <Descriptions.Item label="Leave Travel Allowance (LTA)">₹{payslip.earnings.lta.toLocaleString('en-IN')}</Descriptions.Item>
          <Descriptions.Item label="--">--</Descriptions.Item>
        </Descriptions>

        <Divider style={{ margin: "20px 0" }} />

        <div style={{ display: "flex", justifyContent: "space-between", background: "#f8fafc", padding: "16px", borderRadius: "8px" }}>
          <div>
            <div style={{ fontSize: "12px", color: "#64748b" }}>Total Gross Earnings</div>
            <div style={{ fontSize: "16px", fontWeight: 600, color: "#334155" }}>₹{totalEarnings.toLocaleString('en-IN')}</div>
          </div>
          <div>
            <div style={{ fontSize: "12px", color: "#64748b" }}>Total Deductions</div>
            <div style={{ fontSize: "16px", fontWeight: 600, color: "#ef4444" }}>₹{totalDeductions.toLocaleString('en-IN')}</div>
          </div>
          <div>
            <div style={{ fontSize: "12px", color: "#64748b", fontWeight: 600 }}>Net Take-Home Pay</div>
            <div style={{ fontSize: "20px", fontWeight: 700, color: "#16a34a" }}>₹{netPay.toLocaleString('en-IN')}</div>
          </div>
        </div>
      </div>
    </Modal>
  );
};
