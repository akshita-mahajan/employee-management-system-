import React from "react";
import { Row, Col, Card, Descriptions, Avatar } from "antd";
import { UserOutlined } from "@ant-design/icons";

interface JobInfoTabProps {
  jobDetails: {
    joiningDate: string;
    employeeType: string;
    location: string;
    reportingManager: {
      name: string;
      designation: string;
      email: string;
    };
  };
}

export const JobInfoTab: React.FC<JobInfoTabProps> = ({ jobDetails }) => {
  return (
    <Row gutter={[24, 24]}>
      <Col xs={24} lg={16}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Employment Information</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
        >
          <Descriptions column={{ xs: 1, sm: 2 }} layout="vertical">
            <Descriptions.Item label="Joining Date">{jobDetails.joiningDate}</Descriptions.Item>
            <Descriptions.Item label="Employment Type">{jobDetails.employeeType}</Descriptions.Item>
            <Descriptions.Item label="Work Location">{jobDetails.location}</Descriptions.Item>
          </Descriptions>
        </Card>
      </Col>

      <Col xs={24} lg={8}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Reporting Manager</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
        >
          <div style={{ display: "flex", gap: "16px", alignItems: "center", marginBottom: "20px" }}>
            <Avatar size={48} icon={<UserOutlined />} style={{ backgroundColor: "#eff6ff", color: "#0061FF" }} />
            <div>
              <h4 style={{ margin: 0, fontWeight: 600, color: "#1e293b" }}>{jobDetails.reportingManager.name}</h4>
              <p style={{ margin: 0, fontSize: "12px", color: "#64748b" }}>{jobDetails.reportingManager.designation}</p>
            </div>
          </div>
          <Descriptions column={1} layout="vertical">
            <Descriptions.Item label="Manager Email">{jobDetails.reportingManager.email}</Descriptions.Item>
          </Descriptions>
        </Card>
      </Col>
    </Row>
  );
};
