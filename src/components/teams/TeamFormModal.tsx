import React, { useEffect } from "react";
import { Modal, Form, Input, Select, Button } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

const teamSchema = z.object({
  name: z.string().min(1, "Team Name is required"),
  code: z.string().min(2, "Team Code must be at least 2 characters"),
  department: z.string().min(1, "Department is required"),
  lead: z.string().min(1, "Team Lead assignment is required"),
  membersListString: z.string().min(1, "Please provide at least one team member"),
});

type TeamFormValues = z.infer<typeof teamSchema>;

interface TeamFormModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: any) => void;
  initialValues?: any;
}

export const TeamFormModal: React.FC<TeamFormModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
}) => {
  const { control, handleSubmit, reset } = useForm<TeamFormValues>({
    resolver: zodResolver(teamSchema),
    defaultValues: {
      name: "",
      code: "",
      department: "",
      lead: "",
      membersListString: "",
    },
  });

  useEffect(() => {
    if (initialValues) {
      reset({
        name: initialValues.name,
        code: initialValues.code,
        department: initialValues.department,
        lead: initialValues.lead,
        membersListString: initialValues.membersList.join(", "),
      });
    } else {
      reset({
        name: "",
        code: "",
        department: "",
        lead: "",
        membersListString: "",
      });
    }
  }, [initialValues, reset, open]);

  const handleFormSubmit = (data: TeamFormValues) => {
    const list = data.membersListString.split(",").map((s) => s.trim()).filter((s) => s);
    onSubmit({
      name: data.name,
      code: data.code,
      department: data.department,
      lead: data.lead,
      membersCount: list.length,
      membersList: list,
    });
    reset();
  };

  return (
    <Modal
      title={<span style={{ fontWeight: 700, fontSize: "18px", color: "#1e293b" }}>{initialValues ? "Edit Team" : "Create Team"}</span>}
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
            <Form.Item label="Team Code" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. FE-TEAM" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="department"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Department" required validateStatus={error ? "error" : ""} help={error?.message}>
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

        <Controller
          name="lead"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Team Lead (Manager)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="Assign manager name" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="membersListString"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Team Members (comma separated)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input.TextArea {...field} placeholder="e.g. Alice, Bob, Charlie" style={{ borderRadius: "6px" }} rows={3} />
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
