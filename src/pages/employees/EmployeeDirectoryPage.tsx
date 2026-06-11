import React, { useState } from "react";
import { Link } from "react-router-dom";
import { Table, Button, Row, Col, Space, notification } from "antd";
import { DownloadOutlined, PlusOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { EmployeeFilters } from "../../components/employees/EmployeeFilters";
import { EmployeeCard } from "../../components/employees/EmployeeCard";
import { EmployeeStatusTag } from "../../components/employees/EmployeeStatusTag";
import { AddEmployeeModal } from "../../components/employees/AddEmployeeModal";
import { useEmployees, useCreateEmployee } from "../../hooks/useHRMS";

interface Employee {
  id: string;
  employeeId: string;
  name: string;
  department: string;
  designation: string;
  email: string;
  phone: string;
  joiningDate: string;
  status: "ACTIVE" | "INACTIVE" | "ON_LEAVE" | "TERMINATED" | string;
  role: string;
}

const EmployeeDirectoryPage: React.FC = () => {
  const [viewMode, setViewMode] = useState<"table" | "card">("table");
  const [modalOpen, setModalOpen] = useState(false);
  const [filters, setFilters] = useState({
    search: "",
    department: "",
    status: "",
    role: "",
  });

  const { data: response, isLoading: loading } = useEmployees({
    search: filters.search,
    status: filters.status,
  });
  const employees: Employee[] = response?.data || [];

  const createEmployeeMutation = useCreateEmployee();

  const handleCreateEmployee = async (values: any) => {
    try {
      await createEmployeeMutation.mutateAsync({
        firstName: values.firstName,
        lastName: values.lastName,
        employeeId: values.employeeId,
        email: values.email,
        phone: values.phone,
        department: values.department,
        designation: values.designation,
        joiningDate: values.joiningDate ? values.joiningDate.format("YYYY-MM-DD") : undefined,
        status: values.status,
      });
      notification.success({
        message: "Employee Created",
        description: `${values.firstName} ${values.lastName} was registered in the database.`,
      });
      setModalOpen(false);
    } catch (error) {
      console.error("Create employee failed:", error);
      notification.error({
        message: "Creation Failed",
        description: "Unable to store employee details inside the database.",
      });
    }
  };

  const handleExport = () => {
    notification.info({
      message: "Export Data",
      description: "Employee directory export list triggered. Your download will start shortly.",
    });
  };

  // Filter criteria logic
  const filteredEmployees = employees.filter((emp) => {
    const matchesDept = !filters.department || emp.department === filters.department;
    const matchesRole = !filters.role || emp.role === filters.role;
    return matchesDept && matchesRole;
  });

  const columns: ColumnsType<Employee> = [
    {
      title: "Employee ID",
      dataIndex: "employeeId",
      key: "employeeId",
      sorter: (a, b) => a.employeeId.localeCompare(b.employeeId),
      render: (text) => <span style={{ fontWeight: 600, color: "#475569" }}>{text}</span>,
    },
    {
      title: "Name",
      dataIndex: "name",
      key: "name",
      sorter: (a, b) => a.name.localeCompare(b.name),
      render: (text, record) => (
        <div>
          <Link to={`/employees/${record.id}`} style={{ fontWeight: 600, color: "#1e293b" }}>
            {text}
          </Link>
          <div style={{ fontSize: "12px", color: "#64748b" }}>{record.email}</div>
        </div>
      ),
    },
    {
      title: "Department",
      dataIndex: "department",
      key: "department",
    },
    {
      title: "Designation",
      dataIndex: "designation",
      key: "designation",
    },
    {
      title: "Phone",
      dataIndex: "phone",
      key: "phone",
    },
    {
      title: "Joining Date",
      dataIndex: "joiningDate",
      key: "joiningDate",
    },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status) => <EmployeeStatusTag status={status} />,
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Employee Directory
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Manage staff profiles, department details, and designation assignments.
          </p>
        </Col>
        <Col>
          <Space>
            <Button icon={<DownloadOutlined />} onClick={handleExport} style={{ borderRadius: "6px" }}>
              Export
            </Button>
            <Button
              type="primary"
              icon={<PlusOutlined />}
              onClick={() => setModalOpen(true)}
              style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}
            >
              Add Employee
            </Button>
          </Space>
        </Col>
      </Row>

      <EmployeeFilters
        filters={filters}
        setFilters={setFilters}
        viewMode={viewMode}
        setViewMode={setViewMode}
      />

      {viewMode === "table" ? (
        <Table
          loading={loading}
          columns={columns}
          dataSource={filteredEmployees}
          rowKey="id"
          pagination={{ pageSize: 8, showSizeChanger: true }}
          style={{
            background: "#ffffff",
            border: "1px solid #e2e8f0",
            borderRadius: "8px",
            overflow: "hidden",
          }}
        />
      ) : (
        <Row gutter={[24, 24]}>
          {filteredEmployees.map((emp) => (
            <Col xs={24} sm={12} md={8} xl={6} key={emp.id}>
              <EmployeeCard employee={emp} />
            </Col>
          ))}
        </Row>
      )}

      <AddEmployeeModal
        open={modalOpen}
        onCancel={() => setModalOpen(false)}
        onSubmit={handleCreateEmployee}
      />
    </div>
  );
};

export default EmployeeDirectoryPage;
