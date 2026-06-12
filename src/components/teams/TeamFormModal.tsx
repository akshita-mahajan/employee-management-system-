import React, { useEffect } from "react";
import { Modal, Form, Input, Select, Button } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

const teamSchema = z.object({
  name: z.string().min(1, "Team Name is required"),
  code: z.string().optional(),
  departmentId: z.string().min(1, "Department is required"),
  teamLeadId: z.string().nullable().optional(),
  memberIds: z.array(z.string()).optional(),
});

type TeamFormValues = z.infer<typeof teamSchema>;

interface TeamFormModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: any) => void;
  initialValues?: any;
  departments?: any[];
  employees?: any[];
}

export const TeamFormModal: React.FC<TeamFormModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
  departments = [],
  employees = [],
}) => {
  const { control, handleSubmit, reset } = useForm<TeamFormValues>({
    resolver: zodResolver(teamSchema),
    defaultValues: {
      name: "",
      code: "",
      departmentId: "",
      teamLeadId: null,
      memberIds: [],
    },
  });

  useEffect(() => {
    if (open) {
      if (initialValues) {
        reset({
          name: initialValues.name || "",
          code: initialValues.code || "",
          departmentId: initialValues.department_id || "",
          teamLeadId: initialValues.team_lead_id || null,
          memberIds: initialValues.member_ids || [],
        });
      } else {
        reset({
          name: "",
          code: "",
          departmentId: "",
          teamLeadId: null,
          memberIds: [],
        });
      }
    }
  }, [initialValues, reset, open]);

  const handleFormSubmit = (data: TeamFormValues) => {
    onSubmit(data);
  };

  const deptOptions = departments.map((d: any) => ({
    value: d.id,
    label: `${d.name} (${d.code})`,
  }));

  const employeeOptions = employees.map((emp: any) => ({
    value: emp.id,
    label: `${emp.name} (${emp.designation})`,
  }));

  return (
    <Modal
      title={
        <span style={{ fontWeight: 700, fontSize: "18px" }}>
          {initialValues ? "Edit Team Details" : "Create New Team"}
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
            <Form.Item label="Team Name" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. Frontend Engineers" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="code"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Team Code (Optional)" validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. FE-TEAM" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="departmentId"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Department" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                placeholder="Select Department"
                style={{ width: "100%", height: "40px" }}
                options={deptOptions}
              />
            </Form.Item>
          )}
        />

        <Controller
          name="teamLeadId"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Team Lead" validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                placeholder="Assign Team Lead"
                allowClear
                style={{ width: "100%", height: "40px" }}
                options={employeeOptions}
              />
            </Form.Item>
          )}
        />

        <Controller
          name="memberIds"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Team Members" validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                mode="multiple"
                placeholder="Assign members to team"
                allowClear
                style={{ width: "100%" }}
                options={employeeOptions}
              />
            </Form.Item>
          )}
        />

        <div style={{ textAlign: "right", marginTop: "24px", display: "flex", justifyContent: "flex-end", gap: "12px" }}>
          <Button onClick={onCancel} style={{ borderRadius: "6px", height: "40px" }}>
            Cancel
          </Button>
          <Button type="primary" htmlType="submit" style={{ borderRadius: "6px", height: "40px", backgroundColor: "#0061FF" }}>
            {initialValues ? "Save Changes" : "Create Team"}
          </Button>
        </div>
      </Form>
    </Modal>
  );
};
