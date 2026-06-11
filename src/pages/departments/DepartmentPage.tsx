import React, { useState } from "react";
import { Table, Button, Row, Col, Space, Radio, notification } from "antd";
import { PlusOutlined, UnorderedListOutlined, AppstoreOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { DepartmentStats } from "../../components/departments/DepartmentStats";
import { DepartmentCard } from "../../components/departments/DepartmentCard";
import { DepartmentFormModal } from "../../components/departments/DepartmentFormModal";
import { useDepartments, useCreateDepartment } from "../../hooks/useHRMS";

interface Department {
  id: string;
  name: string;
  code: string;
  head: string;
  employeeCount: number;
  budget: string;
}

const DepartmentPage: React.FC = () => {
  const [viewMode, setViewMode] = useState<"table" | "card">("table");
  const [modalOpen, setModalOpen] = useState(false);
  const [editingDept, setEditingDept] = useState<Department | null>(null);

  const { data: dbDepartments, isLoading: loading } = useDepartments();
  const createDeptMutation = useCreateDepartment();

  const departments: Department[] = (dbDepartments || []).map((d: any) => ({
    id: d.id,
    name: d.name,
    code: d.code,
    head: d.manager_name || "Unassigned",
    employeeCount: 10, // Mock or resolved count
    budget: `$${parseFloat(d.budget || 0).toLocaleString()}`,
  }));

  const handleCreateOrUpdate = async (values: any) => {
    try {
      if (editingDept) {
        notification.warning({
          message: "Edit Department",
          description: "Modification of database department models is disabled in this sprint.",
        });
      } else {
        await createDeptMutation.mutateAsync({
          name: values.name,
          code: values.code,
          description: values.description || "",
          budget: values.budget ? parseFloat(values.budget.replace(/[^0-9.-]+/g, "")) : 0,
        });
        notification.success({
          message: "Department Created",
          description: `Department ${values.name} was successfully created in PostgreSQL.`,
        });
      }
    } catch (err) {
      console.error(err);
      notification.error({
        message: "Action Failed",
        description: "Could not persist department configuration details.",
      });
    }
    setModalOpen(false);
    setEditingDept(null);
  };

  const handleEditTrigger = (record: Department) => {
    setEditingDept(record);
    setModalOpen(true);
  };

  const handleDelete = (_id: string) => {
    notification.warning({
      message: "Delete Protected",
      description: "Deletion of primary organizational departments is restricted.",
    });
  };

  const totalEmployees = departments.reduce((acc, curr) => acc + curr.employeeCount, 0);
  const sumBudgetNum = departments.reduce((acc, curr) => {
    const val = parseFloat(curr.budget.replace(/[^0-9.-]+/g, "")) || 0;
    return acc + val;
  }, 0);

  const columns: ColumnsType<Department> = [
    { title: "Code", dataIndex: "code", key: "code", render: (text) => <span style={{ fontWeight: 600, color: "#475569" }}>{text}</span> },
    { title: "Department Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600, color: "#1e293b" }}>{text}</span> },
    { title: "HOD / Head", dataIndex: "head", key: "head" },
    { title: "Employee Count", dataIndex: "employeeCount", key: "employeeCount" },
    { title: "Budget Allocation", dataIndex: "budget", key: "budget" },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Space>
          <Button type="text" icon={<EditOutlined />} onClick={() => handleEditTrigger(record)} />
          <Button type="text" danger icon={<DeleteOutlined />} onClick={() => handleDelete(record.id)} />
        </Space>
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Department Management
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Add, edit, or configure organization divisions and allocate yearly budgets.
          </p>
        </Col>
        <Col>
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => {
              setEditingDept(null);
              setModalOpen(true);
            }}
            style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
          >
            Create Department
          </Button>
        </Col>
      </Row>

      {/* KPI Section */}
      <DepartmentStats
        totalDepartments={departments.length}
        totalEmployees={totalEmployees}
        totalBudget={`$${sumBudgetNum.toLocaleString()}`}
      />

      {/* List/Grid toggles */}
      <Row justify="end" style={{ marginBottom: "20px" }}>
        <Col>
          <Radio.Group value={viewMode} onChange={(e) => setViewMode(e.target.value)} style={{ height: "40px" }}>
            <Radio.Button value="table" style={{ height: "40px", lineHeight: "38px" }}>
              <UnorderedListOutlined />
            </Radio.Button>
            <Radio.Button value="card" style={{ height: "40px", lineHeight: "38px" }}>
              <AppstoreOutlined />
            </Radio.Button>
          </Radio.Group>
        </Col>
      </Row>

      {viewMode === "table" ? (
        <Table
          loading={loading}
          columns={columns}
          dataSource={departments}
          rowKey="id"
          pagination={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
        />
      ) : (
        <Row gutter={[24, 24]}>
          {departments.map((d) => (
            <Col xs={24} sm={12} md={8} key={d.id}>
              <DepartmentCard
                dept={d}
                onEdit={() => handleEditTrigger(d)}
                onDelete={() => handleDelete(d.id)}
              />
            </Col>
          ))}
        </Row>
      )}

      <DepartmentFormModal
        open={modalOpen}
        onCancel={() => {
          setModalOpen(false);
          setEditingDept(null);
        }}
        onSubmit={handleCreateOrUpdate}
        initialValues={editingDept}
      />
    </div>
  );
};

export default DepartmentPage;
