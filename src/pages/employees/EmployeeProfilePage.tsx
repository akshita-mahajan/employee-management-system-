import React from "react";
import { useParams, Link } from "react-router-dom";
import { Tabs } from "antd";
import { ArrowLeftOutlined } from "@ant-design/icons";

import { ProfileHeader } from "../../components/profile/ProfileHeader";
import { PersonalInfoTab } from "../../components/profile/PersonalInfoTab";
import { JobInfoTab } from "../../components/profile/JobInfoTab";
import { AttendanceInfoTab } from "../../components/profile/AttendanceInfoTab";
import { PayrollInfoTab } from "../../components/profile/PayrollInfoTab";
import { DocumentsInfoTab } from "../../components/profile/DocumentsInfoTab";
import { ROUTES } from "../../constants/routes";

interface EmployeeProfile {
  id: string;
  employeeId: string;
  name: string;
  department: string;
  designation: string;
  email: string;
  phone: string;
  status: string;
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

import { useEmployee } from "../../hooks/useHRMS";

const EmployeeProfilePage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  
  // Fetch real profile details from PostgreSQL database
  const { data, isLoading } = useEmployee(id || "");
  const profile = data as EmployeeProfile | undefined;

  if (isLoading) return <div style={{ padding: "40px", textAlign: "center" }}>Loading Profile...</div>;
  if (!profile) return <div style={{ padding: "40px", textAlign: "center" }}>Employee Profile Not Found</div>;

  const tabItems = [
    {
      key: "overview",
      label: "Overview",
      children: <JobInfoTab jobDetails={profile.jobDetails} />,
    },
    {
      key: "personal",
      label: "Personal Details",
      children: <PersonalInfoTab personalDetails={profile.personalDetails} />,
    },
    {
      key: "attendance",
      label: "Attendance",
      children: <AttendanceInfoTab />,
    },
    {
      key: "payroll",
      label: "Payroll",
      children: <PayrollInfoTab />,
    },
    {
      key: "documents",
      label: "Documents",
      children: <DocumentsInfoTab />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <div style={{ marginBottom: "20px" }}>
        <Link
          to={ROUTES.EMPLOYEES}
          style={{ display: "inline-flex", alignItems: "center", gap: "6px", color: "#64748b", fontWeight: 500 }}
        >
          <ArrowLeftOutlined style={{ fontSize: "14px" }} />
          Back to Directory
        </Link>
      </div>

      <ProfileHeader employee={profile} />

      <Tabs defaultActiveKey="overview" items={tabItems} style={{ background: "#ffffff", padding: "16px", borderRadius: "12px", border: "1px solid #e2e8f0" }} />
    </div>
  );
};

export default EmployeeProfilePage;
