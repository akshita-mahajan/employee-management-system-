import React from "react";
import { Form, Input } from "antd";
import { Controller } from "react-hook-form";

interface PasswordInputProps {
  name: string;
  control: any;
  label?: string;
  placeholder?: string;
  required?: boolean;
}

export const PasswordInput: React.FC<PasswordInputProps> = ({
  name,
  control,
  label = "Password",
  placeholder = "Enter your password",
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
          <Input.Password
            {...field}
            placeholder={placeholder}
            style={{ borderRadius: 6 }}
          />
        </Form.Item>
      )}
    />
  );
};
