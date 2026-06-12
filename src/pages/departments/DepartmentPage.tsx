import React, { useState } from "react";
import { Table, Button, Row, Col, Space, Radio, notification, Popconfirm, Tooltip } from "antd";
import { PlusOutlined, UnorderedListOutlined, AppstoreOutlined, EditOutlined, DeleteOutlined, ReloadOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { DepartmentStats } from "../../components/departments/DepartmentStats";
import { DepartmentCard } from "../../components/departments/DepartmentCard";
import { DepartmentFormModal } from "../../components/departments/DepartmentFormModal";
import { 
  useDepartments, 
  useCreateDepartment, 
  useUpdateDepartment, 
  useDeleteDepartment,
  useEmployees 
} from "../../hooks/useHRMS";

interface Department {
  id: string;
  name: string;
  code: string;
  head: string;
  manager_id: string | null;
  employeeCount: number;
  budget: string;
  description?: string;
}

const DepartmentPage: React.FC = () => {
  const [viewMode, setViewMode] = useState<"table" | "card">("table");
  const [modalOpen, setModalOpen] = useState(false);
  const [editingDept, setEditingDept] = useState<Department | null>(null);

  // Fetch departments and potential employees for HOD assignment
  const { data: dbDepartments, isLoading: loading, refetch } = useDepartments();
  const { data: empResponse } = useEmployees({ limit: 1000 }); // load all active staff members

  const createDeptMutation = useCreateDepartment();
  const updateDeptMutation = useUpdateDepartment();
  const deleteDeptMutation = useDeleteDepartment();

  const employees = empResponse?.data || [];

  // Parse database records to dynamic frontend model
  const departments: Department[] = (dbDepartments || []).map((d: any) => ({
    id: d.id,
    name: d.name,
    code: d.code,
    head: d.manager_name || "Unassigned",
    manager_id: d.manager_id,
    employeeCount: parseInt(d.employee_count || 0),
    budget: `₹${parseFloat(d.budget || 0).toLocaleString("en-IN")}`,
    description: d.description,
  }));

  const handleCreateOrUpdate = async (values: any) => {
    try {
      if (editingDept) {
        await updateDeptMutation.mutateAsync({
          id: editingDept.id,
          payload: {
            name: values.name,
            code: values.code || undefined,
            description: values.description || "",
            managerId: values.managerId || null,
            budget: values.budget || 0,
          },
        });
        notification.success({
          message: "Department Updated",
          description: `Department ${values.name} was successfully modified.`,
        });
      } else {
        await createDeptMutation.mutateAsync({
          name: values.name,
          code: values.code || undefined,
          description: values.description || "",
          managerId: values.managerId || null,
          budget: values.budget || 0,
        });
        notification.success({
          message: "Department Created",
          description: `Department ${values.name} was successfully created.`,
        });
      }
      setModalOpen(false);
      setEditingDept(null);
    } catch (err: any) {
      console.error(err);
      notification.error({
        message: "Action Failed",
        description: err.response?.data?.message || "Could not persist department configuration details.",
      });
    }
  };

  const handleEditTrigger = (record: Department) => {
    setEditingDept(record);
    setModalOpen(true);
  };

  const handleDelete = async (id: string) => {
    try {
      await deleteDeptMutation.mutateAsync(id);
      notification.success({
        message: "Department Deleted",
        description: "The department was soft-deleted successfully.",
      });
    } catch (err: any) {
      console.error(err);
      notification.error({
        message: "Deletion Restrained",
        description: err.response?.data?.message || "Active employees are assigned to this department. Please transfer them first.",
      });
    }
  };

  const totalEmployees = departments.reduce((acc, curr) => acc + curr.employeeCount, 0);
  const sumBudgetNum = departments.reduce((acc, curr) => {
    const val = parseFloat(curr.budget.replace(/[^0-9.-]+/g, "")) || 0;
    return acc + val;
  }, 0);

  const columns: ColumnsType<Department> = [
    { title: "Code", dataIndex: "code", key: "code", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
    { title: "Department Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
    { title: "HOD / Head", dataIndex: "head", key: "head" },
    { title: "Employee Count", dataIndex: "employeeCount", key: "employeeCount" },
    { title: "Budget Allocation", dataIndex: "budget", key: "budget" },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Space>
          <Tooltip title="Edit Department">
            <Button type="text" icon={<EditOutlined />} onClick={() => handleEditTrigger(record)} />
          </Tooltip>
          <Tooltip title="Delete Department">
            <Popconfirm
              title="Delete department?"
              description="Make sure no active employees are assigned."
              onConfirm={() => handleDelete(record.id)}
              okText="Yes, Delete"
              cancelText="No"
              okButtonProps={{ danger: true }}
            >
              <Button type="text" danger icon={<DeleteOutlined />} />
            </Popconfirm>
          </Tooltip>
        </Space>
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, margin: 0 }}>
            Department Management
          </h2>
          <p style={{ margin: "4px 0 0 0", opacity: 0.8, fontSize: "14px" }}>
            Add, edit, or configure organization divisions and allocate yearly budgets.
          </p>
        </Col>
        <Col>
          <Space>
            <Button icon={<ReloadOutlined />} onClick={() => refetch()} />
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
          </Space>
        </Col>
      </Row>

      {/* KPI Section */}
      <DepartmentStats
        totalDepartments={departments.length}
        totalEmployees={totalEmployees}
        totalBudget={`₹${sumBudgetNum.toLocaleString("en-IN")}`}
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
          style={{ borderRadius: "8px", overflow: "hidden" }}
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
        employees={employees} // Provide active employees list for Head selection
      />
    </div>
  );
};

export default DepartmentPage;
