import React, { useEffect, useState } from "react";
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

const mockProfileDatabase: Record<string, EmployeeProfile> = {
  "1": {
    id: "1",
    employeeId: "EMP-001",
    name: "John Admin",
    department: "Human Resources",
    designation: "Lead HR Specialist",
    email: "admin@hrms.com",
    phone: "+1 555-0100",
    status: "ACTIVE",
    personalDetails: {
      firstName: "John",
      lastName: "Admin",
      dob: "1988-11-23",
      gender: "Male",
      maritalStatus: "Married",
      nationality: "American",
      bloodGroup: "O+",
      emergencyContact: {
        name: "Mary Admin",
        relationship: "Spouse",
        phone: "+1 555-0102",
      },
    },
    jobDetails: {
      joiningDate: "2024-01-15",
      employeeType: "Full-Time Permanent",
      location: "San Francisco HQ",
      reportingManager: {
        name: "Sarah CEO",
        designation: "Chief Executive Officer",
        email: "sarah.ceo@company.com",
      },
    },
  },
  "2": {
    id: "2",
    employeeId: "EMP-002",
    name: "Jane Miller",
    department: "Engineering",
    designation: "Senior Software Engineer",
    email: "jane.miller@company.com",
    phone: "+1 555-0122",
    status: "ACTIVE",
    personalDetails: {
      firstName: "Jane",
      lastName: "Miller",
      dob: "1992-05-14",
      gender: "Female",
      maritalStatus: "Single",
      nationality: "American",
      bloodGroup: "A-",
      emergencyContact: {
        name: "David Miller",
        relationship: "Father",
        phone: "+1 555-0125",
      },
    },
    jobDetails: {
      joiningDate: "2024-03-20",
      employeeType: "Full-Time Permanent",
      location: "Remote",
      reportingManager: {
        name: "Marcus Teamlead",
        designation: "Engineering Director",
        email: "marcus.lead@company.com",
      },
    },
  },
};

const EmployeeProfilePage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [profile, setProfile] = useState<EmployeeProfile | null>(null);

  useEffect(() => {
    // Default fallback to John Admin if profile ID is missing or not registered in mocks
    const activeId = id && mockProfileDatabase[id] ? id : "1";
    setProfile(mockProfileDatabase[activeId]);
  }, [id]);

  if (!profile) return <div>Loading Profile...</div>;

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
