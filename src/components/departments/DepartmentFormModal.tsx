import React, { useEffect } from "react";
import { Modal, Form, Input, InputNumber, Button } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

const departmentSchema = z.object({
  name: z.string().min(1, "Department Name is required"),
  code: z.string().min(2, "Department Code must be at least 2 characters"),
  head: z.string().min(1, "Head of Department assignment is required"),
  employeeCount: z.number().min(0, "Employee count must be 0 or more"),
  budget: z.number().min(0, "Allocated Budget must be 0 or more"),
});

type DepartmentFormValues = z.infer<typeof departmentSchema>;

interface DepartmentFormModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: any) => void;
  initialValues?: any;
}

export const DepartmentFormModal: React.FC<DepartmentFormModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
}) => {
  const { control, handleSubmit, reset } = useForm<DepartmentFormValues>({
    resolver: zodResolver(departmentSchema),
    defaultValues: {
      name: "",
      code: "",
      head: "",
      employeeCount: 0,
      budget: 0,
    },
  });

  useEffect(() => {
    if (initialValues) {
      const parsedBudget = parseFloat(initialValues.budget.replace(/[^0-9.-]+/g, "")) || 0;
      reset({
        name: initialValues.name,
        code: initialValues.code,
        head: initialValues.head,
        employeeCount: initialValues.employeeCount,
        budget: parsedBudget,
      });
    } else {
      reset({
        name: "",
        code: "",
        head: "",
        employeeCount: 0,
        budget: 0,
      });
    }
  }, [initialValues, reset, open]);

  const handleFormSubmit = (data: DepartmentFormValues) => {
    onSubmit({
      ...data,
      budget: `$${data.budget.toLocaleString()}`,
    });
    reset();
  };

  return (
    <Modal
      title={<span style={{ fontWeight: 700, fontSize: "18px", color: "#1e293b" }}>{initialValues ? "Edit Department" : "Create Department"}</span>}
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
            <Form.Item label="Department Code" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. ENG" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="head"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Head of Department (HOD)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="Assign supervisor name" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="employeeCount"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Total Allocated Employees" required validateStatus={error ? "error" : ""} help={error?.message}>
              <InputNumber {...field} style={{ width: "100%", borderRadius: "6px", height: "40px", lineHeight: "38px" }} min={0} />
            </Form.Item>
          )}
        />

        <Controller
          name="budget"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Annual Budget Allocation ($)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <InputNumber {...field} style={{ width: "100%", borderRadius: "6px", height: "40px", lineHeight: "38px" }} min={0} />
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
