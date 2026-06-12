import React, { useEffect } from "react";
import { Modal, Form, Input, InputNumber, Button, Select } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

const departmentSchema = z.object({
  name: z.string().min(1, "Department Name is required"),
  code: z.string().optional(),
  managerId: z.string().nullable().optional(),
  budget: z.number().min(0, "Allocated Budget must be 0 or more"),
  description: z.string().optional(),
});

type DepartmentFormValues = z.infer<typeof departmentSchema>;

interface DepartmentFormModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: any) => void;
  initialValues?: any;
  employees?: any[];
}

export const DepartmentFormModal: React.FC<DepartmentFormModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
  employees = [],
}) => {
  const { control, handleSubmit, reset } = useForm<DepartmentFormValues>({
    resolver: zodResolver(departmentSchema),
    defaultValues: {
      name: "",
      code: "",
      managerId: null,
      budget: 0,
      description: "",
    },
  });

  useEffect(() => {
    if (open) {
      if (initialValues) {
        // Parse budget string if necessary
        let parsedBudget = 0;
        if (typeof initialValues.budget === "string") {
          parsedBudget = parseFloat(initialValues.budget.replace(/[^0-9.-]+/g, "")) || 0;
        } else if (typeof initialValues.budget === "number") {
          parsedBudget = initialValues.budget;
        }

        reset({
          name: initialValues.name || "",
          code: initialValues.code || "",
          managerId: initialValues.manager_id || null,
          budget: parsedBudget,
          description: initialValues.description || "",
        });
      } else {
        reset({
          name: "",
          code: "",
          managerId: null,
          budget: 0,
          description: "",
        });
      }
    }
  }, [initialValues, reset, open]);

  const handleFormSubmit = (data: DepartmentFormValues) => {
    onSubmit(data);
  };

  const employeeOptions = employees.map((emp: any) => ({
    value: emp.id,
    label: `${emp.name} (${emp.designation})`,
  }));

  return (
    <Modal
      title={
        <span style={{ fontWeight: 700, fontSize: "18px" }}>
          {initialValues ? "Edit Department Details" : "Create New Department"}
        </span>
      }
      open={open}
      onCancel={onCancel}
      footer={null}
      destroyOnClose
    >
      <Form layout="vertical" onFinish={handleSubmit(handleFormSubmit)} style={{ marginTop: "20px" }}>
        <Controller
          name="name"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Department Name" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. Engineering" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="code"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Department Code (Optional - will auto-generate if empty)" validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. ENG" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="managerId"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Head of Department (HOD)" validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                placeholder="Select HOD from Employees"
                allowClear
                style={{ width: "100%", height: "40px" }}
                options={employeeOptions}
              />
            </Form.Item>
          )}
        />

        <Controller
          name="budget"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Annual Budget Allocation (₹)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <InputNumber {...field} style={{ width: "100%", borderRadius: "6px", height: "40px", lineHeight: "38px" }} min={0} />
            </Form.Item>
          )}
        />

        <Controller
          name="description"
          control={control}
          render={({ field }) => (
            <Form.Item label="Description">
              <Input.TextArea {...field} placeholder="Enter description..." rows={3} style={{ borderRadius: "6px" }} />
            </Form.Item>
          )}
        />

        <div style={{ textAlign: "right", marginTop: "24px", display: "flex", justifyContent: "flex-end", gap: "12px" }}>
          <Button onClick={onCancel} style={{ borderRadius: "6px", height: "40px" }}>
            Cancel
          </Button>
          <Button type="primary" htmlType="submit" style={{ borderRadius: "6px", height: "40px", backgroundColor: "#0061FF" }}>
            {initialValues ? "Save Changes" : "Create Department"}
          </Button>
        </div>
      </Form>
    </Modal>
  );
};
