import React from "react";
import { Modal, Form, Input, DatePicker, Select, Button, Row, Col } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import dayjs from "dayjs";

const employeeFormSchema = z.object({
  employeeId: z.string().min(1, "Employee ID is required"),
  firstName: z.string().min(1, "First Name is required"),
  lastName: z.string().min(1, "Last Name is required"),
  email: z.string().min(1, "Email is required").email("Invalid email address"),
  phone: z.string().min(10, "Phone must be at least 10 characters"),
  department: z.string().min(1, "Department is required"),
  designation: z.string().min(1, "Designation is required"),
  role: z.string().min(1, "Role is required"),
  status: z.string().min(1, "Status is required"),
  joiningDate: z.any().refine((val) => val !== null && val !== undefined, {
    message: "Joining date is required",
  }),
});

type EmployeeFormValues = z.infer<typeof employeeFormSchema>;

interface AddEmployeeModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: EmployeeFormValues) => void;
  initialValues?: any;
}

export const AddEmployeeModal: React.FC<AddEmployeeModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
}) => {
  const isEdit = !!initialValues;
  const { control, handleSubmit, reset } = useForm<EmployeeFormValues>({
    resolver: zodResolver(employeeFormSchema),
    defaultValues: {
      employeeId: "",
      firstName: "",
      lastName: "",
      email: "",
      phone: "",
      department: "",
      designation: "",
      role: "EMPLOYEE",
      status: "ACTIVE",
      joiningDate: null,
    },
  });

  React.useEffect(() => {
    if (open) {
      if (initialValues) {
        reset({
          employeeId: initialValues.employeeId || "",
          firstName: initialValues.firstName || "",
          lastName: initialValues.lastName || "",
          email: initialValues.email || "",
          phone: initialValues.phone || "",
          department: initialValues.department || "",
          designation: initialValues.designation || "",
          role: initialValues.role || "EMPLOYEE",
          status: initialValues.status || "ACTIVE",
          joiningDate: initialValues.joiningDate ? dayjs(initialValues.joiningDate) : null,
        });
      } else {
        reset({
          employeeId: "",
          firstName: "",
          lastName: "",
          email: "",
          phone: "",
          department: "",
          designation: "",
          role: "EMPLOYEE",
          status: "ACTIVE",
          joiningDate: null,
        });
      }
    }
  }, [open, initialValues, reset]);

  const handleFormSubmit = (data: EmployeeFormValues) => {
    onSubmit(data);
  };

  return (
    <Modal
      title={
        <span style={{ fontWeight: 700, fontSize: "18px" }}>
          {isEdit ? "Edit Employee Details" : "Add New Employee"}
        </span>
      }
      open={open}
      onCancel={onCancel}
      footer={null}
      width={720}
      destroyOnClose
    >
      <Form layout="vertical" onFinish={handleSubmit(handleFormSubmit)} style={{ marginTop: "20px" }}>
        <Row gutter={16}>
          <Col span={12}>
            <Controller
              name="employeeId"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Employee ID"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input 
                    {...field} 
                    placeholder="e.g. EMP-101" 
                    disabled={isEdit} // Prevent changing ID in edit mode
                    style={{ borderRadius: "6px", height: "40px" }} 
                  />
                </Form.Item>
              )}
            />
          </Col>
          <Col span={12}>
            <Controller
              name="joiningDate"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Joining Date"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <DatePicker
                    {...field}
                    style={{ width: "100%", borderRadius: "6px", height: "40px" }}
                  />
                </Form.Item>
              )}
            />
          </Col>
        </Row>

        <Row gutter={16}>
          <Col span={12}>
            <Controller
              name="firstName"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="First Name"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input {...field} placeholder="Enter first name" style={{ borderRadius: "6px", height: "40px" }} />
                </Form.Item>
              )}
            />
          </Col>
          <Col span={12}>
            <Controller
              name="lastName"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Last Name"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input {...field} placeholder="Enter last name" style={{ borderRadius: "6px", height: "40px" }} />
                </Form.Item>
              )}
            />
          </Col>
        </Row>

        <Row gutter={16}>
          <Col span={12}>
            <Controller
              name="email"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Email Address"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input {...field} type="email" placeholder="email@company.com" style={{ borderRadius: "6px", height: "40px" }} />
                </Form.Item>
              )}
            />
          </Col>
          <Col span={12}>
            <Controller
              name="phone"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Phone Number"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input {...field} placeholder="e.g. +1 555-0199" style={{ borderRadius: "6px", height: "40px" }} />
                </Form.Item>
              )}
            />
          </Col>
        </Row>

        <Row gutter={16}>
          <Col span={12}>
            <Controller
              name="department"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Department"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Select
                    {...field}
                    placeholder="Select Department"
                    style={{ width: "100%", height: "40px" }}
                    options={[
                      { value: "Engineering", label: "Engineering" },
                      { value: "Product Management", label: "Product Management" },
                      { value: "Marketing", label: "Marketing" },
                      { value: "Human Resources", label: "Human Resources" },
                    ]}
                  />
                </Form.Item>
              )}
            />
          </Col>
          <Col span={12}>
            <Controller
              name="designation"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Designation"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Input {...field} placeholder="e.g. Lead Developer" style={{ borderRadius: "6px", height: "40px" }} />
                </Form.Item>
              )}
            />
          </Col>
        </Row>

        <Row gutter={16}>
          <Col span={12}>
            <Controller
              name="role"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="System Role"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Select
                    {...field}
                    placeholder="Select Role"
                    style={{ width: "100%", height: "40px" }}
                    options={[
                      { value: "ADMIN", label: "Admin" },
                      { value: "HR", label: "HR Manager" },
                      { value: "MANAGER", label: "Manager" },
                      { value: "EMPLOYEE", label: "Employee" },
                    ]}
                  />
                </Form.Item>
              )}
            />
          </Col>
          <Col span={12}>
            <Controller
              name="status"
              control={control}
              render={({ field, fieldState: { error } }) => (
                <Form.Item
                  label="Status"
                  required
                  validateStatus={error ? "error" : ""}
                  help={error?.message}
                >
                  <Select
                    {...field}
                    placeholder="Select Lifecycle Status"
                    style={{ width: "100%", height: "40px" }}
                    options={[
                      { value: "ACTIVE", label: "Active" },
                      { value: "ON_LEAVE", label: "On Leave" },
                      { value: "INACTIVE", label: "Inactive" },
                    ]}
                  />
                </Form.Item>
              )}
            />
          </Col>
        </Row>

        <div style={{ textAlign: "right", marginTop: "24px", display: "flex", justifyContent: "flex-end", gap: "12px" }}>
          <Button onClick={onCancel} style={{ borderRadius: "6px", height: "40px" }}>
            Cancel
          </Button>
          <Button type="primary" htmlType="submit" style={{ borderRadius: "6px", height: "40px", backgroundColor: "#0061FF" }}>
            {isEdit ? "Save Changes" : "Create Employee"}
          </Button>
        </div>
      </Form>
    </Modal>
  );
};
