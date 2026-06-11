import React from "react";
import { Card, Row, Col, Tabs, Form, Input, Button, Switch, Divider, Space, notification } from "antd";
import {
  SettingOutlined,
  UserOutlined,
  BellOutlined,
  SafetyCertificateOutlined,
  DatabaseOutlined,
} from "@ant-design/icons";

const SettingsPage: React.FC = () => {
  const handleSave = () => {
    notification.success({
      message: "Settings Saved",
      description: "Organization configurations updated successfully.",
    });
  };

  const tabItems = [
    {
      key: "company",
      label: (
        <span>
          <SettingOutlined />
          Company Settings
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>Enterprise Details</h3>
          <Form layout="vertical" onFinish={handleSave}>
            <Row gutter={16}>
              <Col span={12}>
                <Form.Item label="Company Name" required>
                  <Input defaultValue="Enterprise Solutions Inc." style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item label="Primary Domain" required>
                  <Input defaultValue="company.com" style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
            </Row>
            <Row gutter={16}>
              <Col span={12}>
                <Form.Item label="System Timezone">
                  <Input defaultValue="UTC (GMT+0)" style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item label="Currency Code">
                  <Input defaultValue="USD ($)" style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
            </Row>
            <Button type="primary" htmlType="submit" style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}>
              Save Company Info
            </Button>
          </Form>
        </Card>
      ),
    },
    {
      key: "profile",
      label: (
        <span>
          <UserOutlined />
          Profile Settings
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>Personal Profile</h3>
          <Form layout="vertical" onFinish={handleSave}>
            <Row gutter={16}>
              <Col span={12}>
                <Form.Item label="Display Name" required>
                  <Input defaultValue="John Admin" style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item label="Contact Email" required>
                  <Input defaultValue="admin@hrms.com" disabled style={{ borderRadius: "6px" }} />
                </Form.Item>
              </Col>
            </Row>
            <Button type="primary" htmlType="submit" style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}>
              Update Profile
            </Button>
          </Form>
        </Card>
      ),
    },
    {
      key: "notifications",
      label: (
        <span>
          <BellOutlined />
          Notification Preferences
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>System Notifications</h3>
          <Space direction="vertical" style={{ width: "100%" }} size="middle">
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
              <div>
                <div style={{ fontWeight: 600 }}>Email Digests</div>
                <div style={{ fontSize: "12px", color: "#64748b" }}>Receive weekly summaries of leaves and attendance actions.</div>
              </div>
              <Switch defaultChecked />
            </div>
            <Divider style={{ margin: 0 }} />
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
              <div>
                <div style={{ fontWeight: 600 }}>Asset Tracking Alerts</div>
                <div style={{ fontSize: "12px", color: "#64748b" }}>Receive warnings when device maintenance reports are created.</div>
              </div>
              <Switch defaultChecked />
            </div>
          </Space>
        </Card>
      ),
    },
    {
      key: "theme",
      label: (
        <span>
          <BellOutlined />
          Theme Settings
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>Visual Preferences</h3>
          <Form layout="vertical" onFinish={handleSave}>
            <Row gutter={16}>
              <Col span={12}>
                <Form.Item label="Dark Mode Alert">
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "8px 12px", background: "#f8fafc", borderRadius: "6px", border: "1px solid #e2e8f0" }}>
                    <span>Enable Dark Mode Theme</span>
                    <Switch />
                  </div>
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item label="Compact View">
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "8px 12px", background: "#f8fafc", borderRadius: "6px", border: "1px solid #e2e8f0" }}>
                    <span>Enable Compact Density</span>
                    <Switch />
                  </div>
                </Form.Item>
              </Col>
            </Row>
            <Button type="primary" htmlType="submit" style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}>
              Save Theme Options
            </Button>
          </Form>
        </Card>
      ),
    },
    {
      key: "security",
      label: (
        <span>
          <SafetyCertificateOutlined />
          Security Settings
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>Access Credentials</h3>
          <Form layout="vertical" onFinish={handleSave}>
            <Form.Item label="Current Password" required>
              <Input.Password style={{ borderRadius: "6px" }} />
            </Form.Item>
            <Form.Item label="New Password" required>
              <Input.Password style={{ borderRadius: "6px" }} />
            </Form.Item>
            <Button type="primary" htmlType="submit" style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}>
              Update Password
            </Button>
          </Form>
        </Card>
      ),
    },
    {
      key: "system",
      label: (
        <span>
          <DatabaseOutlined />
          System Information
        </span>
      ),
      children: (
        <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
          <h3 style={{ margin: "0 0 16px 0", fontSize: "16px", fontWeight: 600 }}>Environment Status</h3>
          <Descriptions column={2} bordered size="small" style={{ marginTop: "12px" }}>
            <Descriptions.Item label="Server Node Version">v20.11.0</Descriptions.Item>
            <Descriptions.Item label="HRMS Frontend Version">v1.2.4 (React 19)</Descriptions.Item>
            <Descriptions.Item label="Neon PG Latency">42ms</Descriptions.Item>
            <Descriptions.Item label="SOC2 Compliance Status">Audit verified</Descriptions.Item>
          </Descriptions>
        </Card>
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", marginBottom: "4px" }}>Settings</h2>
      <p style={{ color: "#64748b", fontSize: "14px", marginBottom: "24px" }}>
        Configure enterprise information, profile details, alerts preferences, and security options.
      </p>

      <Tabs defaultActiveKey="company" tabPosition="left" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />
    </div>
  );
};

// Simple descriptions inline component
const Descriptions: any = ({ children, style }: any) => (
  <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "12px", ...style }}>{children}</div>
);

const DescriptionsItem: any = ({ label, children }: any) => (
  <div style={{ padding: "8px", background: "#f8fafc", borderRadius: "6px", border: "1px solid #e2e8f0" }}>
    <strong style={{ fontSize: "12px", color: "#64748b" }}>{label}:</strong>
    <div style={{ fontSize: "14px", color: "#1e293b", marginTop: "4px" }}>{children}</div>
  </div>
);

// Bind custom descriptions components to main list
Object.assign(Descriptions, { Item: DescriptionsItem });

export default SettingsPage;
