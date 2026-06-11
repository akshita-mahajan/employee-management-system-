import { Outlet } from "react-router-dom";
import { Row, Col, Typography } from "antd";

const { Title, Paragraph } = Typography;

const AuthLayout = () => {
  return (
    <Row style={{ minHeight: "100vh", margin: 0, width: "100%" }}>
      {/* Left Column: Visual branding and illustrations */}
      <Col
        xs={0}
        lg={12}
        style={{
          background: "linear-gradient(135deg, #091E3A 0%, #0061FF 50%, #4A00E0 100%)",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "center",
          padding: "60px",
          color: "#ffffff",
          position: "relative",
          overflow: "hidden",
        }}
      >
        <div style={{ zIndex: 2, maxWidth: "480px" }}>
          <div
            style={{
              display: "inline-flex",
              alignItems: "center",
              gap: "8px",
              marginBottom: "32px",
            }}
          >
            <div
              style={{
                width: "40px",
                height: "40px",
                background: "#ffffff",
                borderRadius: "8px",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontWeight: 800,
                fontSize: "22px",
                color: "#0061FF",
                boxShadow: "0 4px 12px rgba(0, 0, 0, 0.15)",
              }}
            >
              H
            </div>
            <span style={{ fontSize: "22px", fontWeight: 700, letterSpacing: "0.5px" }}>
              Enterprise HRMS
            </span>
          </div>

          <Title level={1} style={{ color: "#ffffff", margin: "0 0 16px 0", fontSize: "38px", fontWeight: 700, lineHeight: 1.2 }}>
            Manage Your Unified Workforce Smartly.
          </Title>

          <Paragraph style={{ color: "rgba(255, 255, 255, 0.85)", fontSize: "16px", lineHeight: "1.6", marginBottom: "40px" }}>
            A modern, secure, and enterprise-grade workforce management platform mapping all core HR attributes, attendance metrics, recruitment flows, and performance evaluations.
          </Paragraph>

          {/* Feature highlights grid */}
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "24px" }}>
            {[
              { title: "SaaS Automation", desc: "Automated payroll & leaves processing" },
              { title: "Role Protections", desc: "Access scopes based on organization roles" },
              { title: "Detailed Analytics", desc: "Visual workforce statistics dashboard" },
              { title: "Compliance Shield", desc: "Standard SOC2 & GDPR ready designs" },
            ].map((feature, idx) => (
              <div key={idx} style={{ background: "rgba(255, 255, 255, 0.08)", padding: "16px", borderRadius: "8px", border: "1px solid rgba(255, 255, 255, 0.12)" }}>
                <h4 style={{ margin: "0 0 4px 0", color: "#ffffff", fontSize: "15px", fontWeight: 600 }}>{feature.title}</h4>
                <p style={{ margin: 0, color: "rgba(255, 255, 255, 0.7)", fontSize: "13px" }}>{feature.desc}</p>
              </div>
            ))}
          </div>
        </div>

        {/* Dynamic design background accents */}
        <div style={{ position: "absolute", bottom: "-10%", right: "-10%", width: "400px", height: "400px", background: "rgba(255,255,255,0.03)", borderRadius: "50%", zIndex: 1 }} />
        <div style={{ position: "absolute", top: "-5%", left: "-5%", width: "250px", height: "250px", background: "rgba(255,255,255,0.03)", borderRadius: "50%", zIndex: 1 }} />
      </Col>

      {/* Right Column: Centered authentication screens */}
      <Col
        xs={24}
        lg={12}
        style={{
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "center",
          background: "#f8fafc",
          padding: "40px 20px",
        }}
      >
        <div style={{ width: "100%", maxWidth: "440px" }}>
          <Outlet />
        </div>
      </Col>
    </Row>
  );
};

export default AuthLayout;
