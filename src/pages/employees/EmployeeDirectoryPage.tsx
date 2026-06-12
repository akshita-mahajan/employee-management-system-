import React, { useState } from "react";
import { Link } from "react-router-dom";
import { Table, Button, Row, Col, Space, notification, Popconfirm, Tooltip } from "antd";
import { DownloadOutlined, PlusOutlined, EditOutlined, DeleteOutlined, ReloadOutlined } from "@ant-design/icons";
import type { ColumnsType, TablePaginationConfig } from "antd/es/table";
import type { FilterValue, SorterResult } from "antd/es/table/interface";

import { EmployeeFilters } from "../../components/employees/EmployeeFilters";
import { EmployeeCard } from "../../components/employees/EmployeeCard";
import { EmployeeStatusTag } from "../../components/employees/EmployeeStatusTag";
import { AddEmployeeModal } from "../../components/employees/AddEmployeeModal";
import { 
  useEmployees, 
  useCreateEmployee, 
  useUpdateEmployee, 
  useDeleteEmployee,
  useDepartments 
} from "../../hooks/useHRMS";

import { useAuthStore } from "../../app/store/authStore";

interface Employee {
  id: string;
  employeeId: string;
  name: string;
  firstName: string;
  lastName: string;
  department: string;
  departmentId: string;
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
  const [editingEmployee, setEditingEmployee] = useState<Employee | null>(null);

  const { user } = useAuthStore();
  const userRole = user?.role || "EMPLOYEE";
  const canManage = ["SUPER_ADMIN", "ADMIN", "HR_ADMIN", "HR"].includes(userRole);

  // Search & Filter parameters
  const [search, setSearch] = useState("");
  const [selectedDeptId, setSelectedDeptId] = useState("");
  const [selectedStatus, setSelectedStatus] = useState("");
  const [selectedRole, setSelectedRole] = useState("");

  // Pagination & Sorting parameters
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(8);
  const [sortBy, setSortBy] = useState<string>("employee_id");
  const [sortOrder, setSortOrder] = useState<"ASC" | "DESC">("ASC");

  // Fetch departments for filtering options
  const { data: depts = [] } = useDepartments();

  // Fetch employees with pagination, search, sorting and filters
  const { data: response, isLoading: loading, refetch } = useEmployees({
    page: currentPage,
    limit: pageSize,
    search: search || undefined,
    status: selectedStatus || undefined,
    departmentId: selectedDeptId || undefined,
    sortBy,
    sortOrder,
  });

  const employees: Employee[] = response?.data || [];
  const totalRecords = response?.metadata?.total || 0;

  const createEmployeeMutation = useCreateEmployee();
  const updateEmployeeMutation = useUpdateEmployee();
  const deleteEmployeeMutation = useDeleteEmployee();

  const handleCreateOrUpdateEmployee = async (values: any) => {
    try {
      // Find resolved department ID if name is selected
      let deptId = values.department;
      const matchingDept = depts.find((d: any) => d.name === values.department || d.id === values.department);
      if (matchingDept) {
        deptId = matchingDept.id;
      }

      if (editingEmployee) {
        // Update employee
        await updateEmployeeMutation.mutateAsync({
          id: editingEmployee.id,
          payload: {
            firstName: values.firstName,
            lastName: values.lastName,
            employeeId: values.employeeId,
            email: values.email,
            phone: values.phone,
            departmentId: deptId,
            designation: values.designation,
            joiningDate: values.joiningDate ? values.joiningDate.format("YYYY-MM-DD") : undefined,
            status: values.status,
          },
        });
        notification.success({
          message: "Employee Updated",
          description: `${values.firstName} ${values.lastName}'s profile details have been saved.`,
        });
      } else {
        // Create employee
        await createEmployeeMutation.mutateAsync({
          firstName: values.firstName,
          lastName: values.lastName,
          employeeId: values.employeeId,
          email: values.email,
          phone: values.phone,
          departmentId: deptId,
          designation: values.designation,
          joiningDate: values.joiningDate ? values.joiningDate.format("YYYY-MM-DD") : undefined,
          status: values.status,
        });
        notification.success({
          message: "Employee Registered",
          description: `${values.firstName} ${values.lastName} was added to the workspace.`,
        });
      }
      setModalOpen(false);
      setEditingEmployee(null);
    } catch (error: any) {
      console.error("Save employee failed:", error);
      notification.error({
        message: "Operation Failed",
        description: error.response?.data?.message || "Unable to update/create employee record inside the database.",
      });
    }
  };

  const handleDeleteEmployee = async (id: string) => {
    try {
      await deleteEmployeeMutation.mutateAsync(id);
      notification.success({
        message: "Employee Soft Deleted",
        description: "The employee was marked inactive and soft-deleted.",
      });
    } catch (error) {
      console.error("Delete employee failed:", error);
      notification.error({
        message: "Deletion Failed",
        description: "An error occurred while removing the employee from the database.",
      });
    }
  };

  const handleExport = () => {
    notification.info({
      message: "Export Data",
      description: "Employee directory export list triggered. Your download will start shortly.",
    });
  };

  // Handle pagination and sorting from table headers
  const handleTableChange = (
    pagination: TablePaginationConfig,
    _filters: Record<string, FilterValue | null>,
    sorter: SorterResult<Employee> | SorterResult<Employee>[]
  ) => {
    if (pagination.current) setCurrentPage(pagination.current);
    if (pagination.pageSize) setPageSize(pagination.pageSize);

    if (sorter && !Array.isArray(sorter) && sorter.field) {
      setSortBy(sorter.field as string);
      setSortOrder(sorter.order === "descend" ? "DESC" : "ASC");
    }
  };

  const filterState = {
    search,
    department: selectedDeptId,
    status: selectedStatus,
    role: selectedRole,
  };

  const setFilters = (updated: any) => {
    setSearch(updated.search);
    setSelectedDeptId(updated.department);
    setSelectedStatus(updated.status);
    setSelectedRole(updated.role);
    setCurrentPage(1); // Reset to first page when filters change
  };

  const baseColumns: ColumnsType<Employee> = [
    {
      title: "Employee ID",
      dataIndex: "employeeId",
      key: "employeeId",
      sorter: true,
      render: (text) => <span style={{ fontWeight: 600 }}>{text}</span>,
    },
    {
      title: "Name",
      dataIndex: "name",
      key: "name",
      sorter: true,
      render: (text, record) => (
        <div>
          <Link to={`/employees/${record.id}`} style={{ fontWeight: 600 }}>
            {text}
          </Link>
          <div style={{ fontSize: "12px", opacity: 0.75 }}>{record.email}</div>
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

  const actionsColumn = {
    title: "Actions",
    key: "actions",
    render: (_: any, record: Employee) => (
      <Space size="middle">
        <Tooltip title="Edit Profile">
          <Button
            type="text"
            icon={<EditOutlined />}
            onClick={() => {
              setEditingEmployee(record);
              setModalOpen(true);
            }}
          />
        </Tooltip>
        <Tooltip title="Delete Employee">
          <Popconfirm
            title="Delete employee profile?"
            description="This will soft-delete the employee record."
            onConfirm={() => handleDeleteEmployee(record.id)}
            okText="Yes, Delete"
            cancelText="No"
            okButtonProps={{ danger: true }}
          >
            <Button type="text" danger icon={<DeleteOutlined />} />
          </Popconfirm>
        </Tooltip>
      </Space>
    ),
  };

  const columns = canManage ? [...baseColumns, actionsColumn] : baseColumns;

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, margin: 0 }}>
            Employee Directory
          </h2>
          <p style={{ margin: "4px 0 0 0", opacity: 0.8, fontSize: "14px" }}>
            Manage staff profiles, department details, and designation assignments.
          </p>
        </Col>
        <Col>
          <Space>
            <Button icon={<ReloadOutlined />} onClick={() => refetch()} />
            <Button icon={<DownloadOutlined />} onClick={handleExport} style={{ borderRadius: "6px" }}>
              Export
            </Button>
            {canManage && (
              <Button
                type="primary"
                icon={<PlusOutlined />}
                onClick={() => {
                  setEditingEmployee(null);
                  setModalOpen(true);
                }}
                style={{ backgroundColor: "#0061FF", borderRadius: "6px" }}
              >
                Add Employee
              </Button>
            )}
          </Space>
        </Col>
      </Row>

      <EmployeeFilters
        filters={filterState}
        setFilters={setFilters}
        viewMode={viewMode}
        setViewMode={setViewMode}
        departments={depts} // Pass depts down for dynamic option loading
      />

      {viewMode === "table" ? (
        <Table
          loading={loading}
          columns={columns}
          dataSource={employees}
          rowKey="id"
          pagination={{
            current: currentPage,
            pageSize: pageSize,
            total: totalRecords,
            showSizeChanger: true,
            pageSizeOptions: ["8", "12", "20", "50"],
          }}
          onChange={handleTableChange}
          style={{
            borderRadius: "8px",
            overflow: "hidden",
          }}
        />
      ) : (
        <Row gutter={[24, 24]}>
          {employees.map((emp) => (
            <Col xs={24} sm={12} md={8} xl={6} key={emp.id}>
              <EmployeeCard employee={emp} />
            </Col>
          ))}
        </Row>
      )}

      <AddEmployeeModal
        open={modalOpen}
        onCancel={() => {
          setModalOpen(false);
          setEditingEmployee(null);
        }}
        onSubmit={handleCreateOrUpdateEmployee}
        initialValues={editingEmployee}
      />
    </div>
  );
};

export default EmployeeDirectoryPage;
