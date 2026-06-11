import React from "react";
import { Form, Input } from "antd";
import { Controller } from "react-hook-form";

interface EmailInputProps {
  name: string;
  control: any;
  label?: string;
  placeholder?: string;
  required?: boolean;
}

export const EmailInput: React.FC<EmailInputProps> = ({
  name,
  control,
  label = "Email Address",
  placeholder = "Enter your email address",
  required = true,
}) => {
  return (
    <Controller
      name={name}
      control={control}
      render={({ field, fieldState: { error } }) => (
        <Form.Item
          label={<span style={{ fontWeight: 500 }}>{label}</span>}
          required={required}
          validateStatus={error ? "error" : ""}
          help={error?.message}
          style={{ marginBottom: 20 }}
        >
          <Input
            {...field}
            type="email"
            placeholder={placeholder}
            style={{ borderRadius: 6 }}
          />
        </Form.Item>
      )}
    />
  );
};
