import React from "react";
import { Row, Col, Input, Select, Radio } from "antd";
import { SearchOutlined, AppstoreOutlined, UnorderedListOutlined } from "@ant-design/icons";

interface EmployeeFiltersProps {
  filters: {
    search: string;
    department: string;
    status: string;
    role: string;
  };
  setFilters: (filters: any) => void;
  viewMode: "table" | "card";
  setViewMode: (mode: "table" | "card") => void;
}

export const EmployeeFilters: React.FC<EmployeeFiltersProps> = ({
  filters,
  setFilters,
  viewMode,
  setViewMode,
}) => {
  return (
    <Row gutter={[16, 16]} style={{ marginBottom: "20px" }} align="middle">
      <Col xs={24} md={8}>
        <Input
          prefix={<SearchOutlined style={{ color: "#94a3b8" }} />}
          placeholder="Search by name, ID, email..."
          value={filters.search}
          onChange={(e) => setFilters({ ...filters, search: e.target.value })}
          style={{ height: "40px", borderRadius: "6px" }}
        />
      </Col>
      <Col xs={12} sm={8} md={4}>
        <Select
          placeholder="Department"
          value={filters.department || undefined}
          onChange={(val) => setFilters({ ...filters, department: val || "" })}
          style={{ width: "100%", height: "40px" }}
          allowClear
          options={[
            { value: "Engineering", label: "Engineering" },
            { value: "Product Management", label: "Product Management" },
            { value: "Marketing", label: "Marketing" },
            { value: "Human Resources", label: "Human Resources" },
          ]}
        />
      </Col>
      <Col xs={12} sm={8} md={4}>
        <Select
          placeholder="Status"
          value={filters.status || undefined}
          onChange={(val) => setFilters({ ...filters, status: val || "" })}
          style={{ width: "100%", height: "40px" }}
          allowClear
          options={[
            { value: "ACTIVE", label: "Active" },
            { value: "ON_LEAVE", label: "On Leave" },
            { value: "INACTIVE", label: "Inactive" },
          ]}
        />
      </Col>
      <Col xs={12} sm={8} md={4}>
        <Select
          placeholder="Role"
          value={filters.role || undefined}
          onChange={(val) => setFilters({ ...filters, role: val || "" })}
          style={{ width: "100%", height: "40px" }}
          allowClear
          options={[
            { value: "ADMIN", label: "Admin" },
            { value: "HR", label: "HR Manager" },
            { value: "MANAGER", label: "Manager" },
            { value: "EMPLOYEE", label: "Employee" },
          ]}
        />
      </Col>
      <Col xs={12} md={4} style={{ textAlign: "right" }}>
        <Radio.Group
          value={viewMode}
          onChange={(e) => setViewMode(e.target.value)}
          style={{ height: "40px" }}
        >
          <Radio.Button value="table" style={{ height: "40px", lineHeight: "38px" }}>
            <UnorderedListOutlined />
          </Radio.Button>
          <Radio.Button value="card" style={{ height: "40px", lineHeight: "38px" }}>
            <AppstoreOutlined />
          </Radio.Button>
        </Radio.Group>
      </Col>
    </Row>
  );
};
