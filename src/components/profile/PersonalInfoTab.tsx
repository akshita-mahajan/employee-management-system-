import React from "react";
import { Row, Col, Card, Descriptions } from "antd";

interface PersonalInfoTabProps {
  personalDetails: {
    firstName: string;
    lastName: string;
    dob: string;
    gender: string;
    maritalStatus: string;
    nationality: string;
    bloodGroup: string;
    emergencyContact: {
      name: string;
      relationship: string;
      phone: string;
    };
  };
}

export const PersonalInfoTab: React.FC<PersonalInfoTabProps> = ({ personalDetails }) => {
  return (
    <Row gutter={[24, 24]}>
      <Col xs={24} lg={16}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Personal Information</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
        >
          <Descriptions column={{ xs: 1, sm: 2 }} layout="vertical">
            <Descriptions.Item label="First Name">{personalDetails.firstName}</Descriptions.Item>
            <Descriptions.Item label="Last Name">{personalDetails.lastName}</Descriptions.Item>
            <Descriptions.Item label="Date of Birth">{personalDetails.dob}</Descriptions.Item>
            <Descriptions.Item label="Gender">{personalDetails.gender}</Descriptions.Item>
            <Descriptions.Item label="Marital Status">{personalDetails.maritalStatus}</Descriptions.Item>
            <Descriptions.Item label="Nationality">{personalDetails.nationality}</Descriptions.Item>
            <Descriptions.Item label="Blood Group">{personalDetails.bloodGroup}</Descriptions.Item>
          </Descriptions>
        </Card>
      </Col>

      <Col xs={24} lg={8}>
        <Card
          title={<span style={{ fontWeight: 600 }}>Emergency Contact</span>}
          bordered={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
        >
          <Descriptions column={1} layout="vertical">
            <Descriptions.Item label="Contact Name">
              <span style={{ fontWeight: 600, color: "#1e293b" }}>{personalDetails.emergencyContact.name}</span>
            </Descriptions.Item>
            <Descriptions.Item label="Relationship">{personalDetails.emergencyContact.relationship}</Descriptions.Item>
            <Descriptions.Item label="Phone Number">{personalDetails.emergencyContact.phone}</Descriptions.Item>
          </Descriptions>
        </Card>
      </Col>
    </Row>
  );
};
