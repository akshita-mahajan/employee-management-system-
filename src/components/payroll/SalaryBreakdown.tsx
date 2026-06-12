import React from "react";
import { Card, Descriptions } from "antd";

export const SalaryBreakdown: React.FC = () => {
  return (
    <Card
      title={<span style={{ fontWeight: 600 }}>Standard Base Salary Structure (Grade A)</span>}
      bordered={false}
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
    >
      <Descriptions column={{ xs: 1, sm: 2 }} bordered size="middle">
        <Descriptions.Item label="Basic Salary Component">50% of Total CTC</Descriptions.Item>
        <Descriptions.Item label="House Rent Allowance (HRA)">40% of Basic Salary</Descriptions.Item>
        <Descriptions.Item label="Leave Travel Allowance (LTA)">10% of Basic Salary</Descriptions.Item>
        <Descriptions.Item label="Provident Fund (PF) Matching">12% of Basic + DA</Descriptions.Item>
        <Descriptions.Item label="Medical Insurance Group coverage">Standard Corporate Plan (₹40,000/yr)</Descriptions.Item>
        <Descriptions.Item label="Bonus Metrics Eligibility">Performance Linked (Annual payout)</Descriptions.Item>
      </Descriptions>
    </Card>
  );
};
