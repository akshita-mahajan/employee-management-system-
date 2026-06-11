import React, { useEffect } from "react";
import { Modal, Form, Input, Select, Button, InputNumber } from "antd";
import { useForm, Controller } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

const assetSchema = z.object({
  name: z.string().min(1, "Asset Name is required"),
  code: z.string().min(2, "Asset Serial Code is required"),
  category: z.string().min(1, "Category is required"),
  status: z.string().min(1, "Status is required"),
  value: z.number().min(0, "Asset value must be positive"),
});

type AssetFormValues = z.infer<typeof assetSchema>;

interface AssetFormModalProps {
  open: boolean;
  onCancel: () => void;
  onSubmit: (values: any) => void;
  initialValues?: any;
}

export const AssetFormModal: React.FC<AssetFormModalProps> = ({
  open,
  onCancel,
  onSubmit,
  initialValues,
}) => {
  const { control, handleSubmit, reset } = useForm<AssetFormValues>({
    resolver: zodResolver(assetSchema),
    defaultValues: {
      name: "",
      code: "",
      category: "",
      status: "Available",
      value: 0,
    },
  });

  useEffect(() => {
    if (initialValues) {
      reset({
        name: initialValues.name,
        code: initialValues.code,
        category: initialValues.category,
        status: initialValues.status,
        value: initialValues.value,
      });
    } else {
      reset({
        name: "",
        code: "",
        category: "",
        status: "Available",
        value: 0,
      });
    }
  }, [initialValues, reset, open]);

  const handleFormSubmit = (data: AssetFormValues) => {
    onSubmit(data);
    reset();
  };

  return (
    <Modal
      title={<span style={{ fontWeight: 700, fontSize: "18px" }}>{initialValues ? "Edit Asset" : "Register Asset"}</span>}
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
            <Form.Item label="Asset Name" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. MacBook Pro M3" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="code"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Serial Code" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Input {...field} placeholder="e.g. SN-MBP2026" style={{ borderRadius: "6px", height: "40px" }} />
            </Form.Item>
          )}
        />

        <Controller
          name="category"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Category" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                placeholder="Select Category"
                style={{ width: "100%", height: "40px" }}
                options={[
                  { value: "Laptop", label: "Laptop" },
                  { value: "Monitor", label: "Monitor" },
                  { value: "Phone", label: "Phone" },
                  { value: "SIM Card", label: "SIM Card" },
                  { value: "Software License", label: "Software License" },
                ]}
              />
            </Form.Item>
          )}
        />

        <Controller
          name="status"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Lifecycle Status" required validateStatus={error ? "error" : ""} help={error?.message}>
              <Select
                {...field}
                placeholder="Select Status"
                style={{ width: "100%", height: "40px" }}
                options={[
                  { value: "Available", label: "Available" },
                  { value: "Assigned", label: "Assigned" },
                  { value: "Under Repair", label: "Under Repair" },
                  { value: "Lost", label: "Lost" },
                  { value: "Retired", label: "Retired" },
                ]}
              />
            </Form.Item>
          )}
        />

        <Controller
          name="value"
          control={control}
          render={({ field, fieldState: { error } }) => (
            <Form.Item label="Value ($)" required validateStatus={error ? "error" : ""} help={error?.message}>
              <InputNumber {...field} style={{ width: "100%", borderRadius: "6px", height: "40px", lineHeight: "38px" }} min={0} />
            </Form.Item>
          )}
        />

        <div style={{ textAlign: "right", marginTop: "24px", display: "flex", justifyContent: "flex-end", gap: "12px" }}>
          <Button onClick={onCancel} style={{ borderRadius: "6px", height: "40px" }}>
            Cancel
          </Button>
          <Button type="primary" htmlType="submit" style={{ borderRadius: "6px", height: "40px", backgroundColor: "#0061FF" }}>
            {initialValues ? "Save Changes" : "Register Asset"}
          </Button>
        </div>
      </Form>
    </Modal>
  );
};
