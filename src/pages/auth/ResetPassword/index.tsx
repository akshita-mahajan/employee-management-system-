import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Card, Form, Alert, notification } from "antd";
import { LockOutlined, ArrowLeftOutlined } from "@ant-design/icons";

import { PasswordInput } from "../../../components/forms/PasswordInput";
import { AuthButton } from "../../../components/forms/AuthButton";
import { ROUTES } from "../../../constants/routes";

const resetSchema = z
  .object({
    password: z.string().min(6, "Password must be at least 6 characters"),
    confirmPassword: z.string().min(1, "Please confirm your password"),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "Passwords do not match",
    path: ["confirmPassword"],
  });

type ResetFormValues = z.infer<typeof resetSchema>;

const ResetPassword: React.FC = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const { control, handleSubmit } = useForm<ResetFormValues>({
    resolver: zodResolver(resetSchema),
    defaultValues: {
      password: "",
      confirmPassword: "",
    },
  });

  const onSubmit = (_data: ResetFormValues) => {
    setLoading(true);
    setErrorMsg(null);

    // Simulate API reset latency
    setTimeout(() => {
      setLoading(false);
      notification.success({
        message: "Password Updated",
        description: "Your login credentials have been updated successfully.",
        placement: "topRight",
      });
      navigate(ROUTES.LOGIN);
    }, 1200);
  };

  return (
    <Card
      bordered={false}
      style={{
        borderRadius: "12px",
        boxShadow: "0 8px 30px rgba(0, 0, 0, 0.04)",
        padding: "12px 8px",
      }}
    >
      <div style={{ textAlign: "center", marginBottom: "32px" }}>
        <div
          style={{
            display: "inline-flex",
            alignItems: "center",
            justifyContent: "center",
            width: "48px",
            height: "48px",
            background: "#eff6ff",
            borderRadius: "50%",
            color: "#0061FF",
            fontSize: "20px",
            marginBottom: "16px",
          }}
        >
          <LockOutlined />
        </div>
        <h2 style={{ fontSize: "24px", fontWeight: 700, margin: "0 0 8px 0", color: "#1e293b" }}>
          Reset Password
        </h2>
        <p style={{ margin: 0, color: "#64748b", fontSize: "14px" }}>
          Please choose a strong, secure new password that is easy for you to remember.
        </p>
      </div>

      {errorMsg && (
        <Alert
          message={errorMsg}
          type="error"
          showIcon
          style={{ marginBottom: "20px", borderRadius: "6px" }}
        />
      )}

      <Form layout="vertical" onFinish={handleSubmit(onSubmit)}>
        <PasswordInput name="password" label="New Password" placeholder="Minimum 6 characters" control={control} />
        
        <PasswordInput
          name="confirmPassword"
          label="Confirm Password"
          placeholder="Repeat your password"
          control={control}
        />

        <AuthButton loading={loading} style={{ marginBottom: "20px" }}>
          Update Password
        </AuthButton>
      </Form>

      <div style={{ textAlign: "center" }}>
        <Link
          to={ROUTES.LOGIN}
          style={{
            display: "inline-flex",
            alignItems: "center",
            gap: "6px",
            color: "#64748b",
            fontSize: "14px",
            fontWeight: 500,
          }}
        >
          <ArrowLeftOutlined style={{ fontSize: "12px" }} />
          Back to Login
        </Link>
      </div>
    </Card>
  );
};

export default ResetPassword;
