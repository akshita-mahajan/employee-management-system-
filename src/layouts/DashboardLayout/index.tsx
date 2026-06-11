import { Outlet } from "react-router-dom";
import { Layout } from "antd";
import { Sidebar } from "../../components/sidebar/Sidebar";
import { Navbar } from "../../components/navbar/Navbar";

const { Content } = Layout;

const DashboardLayout = () => {
  return (
    <Layout style={{ minHeight: "100vh", backgroundColor: "#f8fafc" }}>
      {/* Sidebar Panel Navigation */}
      <Sidebar />

      <Layout style={{ minWidth: 0 }}>
        {/* Top Navbar Header */}
        <Navbar />

        {/* Main Content Area */}
        <Content
          style={{
            margin: "24px",
            padding: "24px",
            background: "#ffffff",
            borderRadius: "8px",
            minHeight: "280px",
            border: "1px solid #e2e8f0",
            boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
            overflow: "auto",
          }}
        >
          <Outlet />
        </Content>
      </Layout>
    </Layout>
  );
};

export default DashboardLayout;
