import React, { useState } from "react";
import { Link } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Card, Form, Alert } from "antd";
import { ArrowLeftOutlined, KeyOutlined } from "@ant-design/icons";

import { EmailInput } from "../../../components/forms/EmailInput";
import { AuthButton } from "../../../components/forms/AuthButton";
import { ROUTES } from "../../../constants/routes";

const forgotSchema = z.object({
  email: z.string().min(1, "Email is required").email("Please enter a valid email address"),
});

type ForgotFormValues = z.infer<typeof forgotSchema>;

const ForgotPassword: React.FC = () => {
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const { control, handleSubmit } = useForm<ForgotFormValues>({
    resolver: zodResolver(forgotSchema),
    defaultValues: {
      email: "",
    },
  });

  const onSubmit = (_data: ForgotFormValues) => {
    setLoading(true);
    // Simulate API logic
    setTimeout(() => {
      setLoading(false);
      setSuccess(true);
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
            background: "#f0fdf4",
            borderRadius: "50%",
            color: "#16a34a",
            fontSize: "20px",
            marginBottom: "16px",
          }}
        >
          <KeyOutlined />
        </div>
        <h2 style={{ fontSize: "24px", fontWeight: 700, margin: "0 0 8px 0", color: "#1e293b" }}>
          Forgot Password
        </h2>
        <p style={{ margin: 0, color: "#64748b", fontSize: "14px" }}>
          No worries, we'll send you an email containing links to reset your secure account password.
        </p>
      </div>

      {success ? (
        <Alert
          message="Password reset link sent!"
          description="If an account exists for this address, a reset email will arrive shortly."
          type="success"
          showIcon
          style={{ marginBottom: "24px", borderRadius: "6px" }}
        />
      ) : (
        <Form layout="vertical" onFinish={handleSubmit(onSubmit)}>
          <EmailInput name="email" control={control} />

          <AuthButton loading={loading} style={{ marginBottom: "20px" }}>
            Send Reset Link
          </AuthButton>
        </Form>
      )}

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

export default ForgotPassword;
