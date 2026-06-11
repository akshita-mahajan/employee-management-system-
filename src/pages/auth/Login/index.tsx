import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Card, Form, Checkbox, Divider, Button, Alert } from "antd";
import { GoogleOutlined, WindowsOutlined, SafetyCertificateOutlined } from "@ant-design/icons";

import { EmailInput } from "../../../components/forms/EmailInput";
import { PasswordInput } from "../../../components/forms/PasswordInput";
import { AuthButton } from "../../../components/forms/AuthButton";
import { ROUTES } from "../../../constants/routes";
import { useAuthStore } from "../../../app/store/authStore";
import { authService } from "../../../services/auth/authService";

const loginSchema = z.object({
  email: z.string().min(1, "Email is required").email("Please enter a valid email address"),
  password: z.string().min(6, "Password must be at least 6 characters"),
  rememberMe: z.boolean().optional(),
});

type LoginFormValues = z.infer<typeof loginSchema>;

const Login: React.FC = () => {
  const navigate = useNavigate();
  const setToken = useAuthStore((state) => state.setToken);
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const { control, handleSubmit } = useForm<LoginFormValues>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: "",
      password: "",
      rememberMe: false,
    },
  });

  const onSubmit = async (data: LoginFormValues) => {
    setLoading(true);
    setErrorMsg(null);
    try {
      const response = await authService.login({
        email: data.email,
        password: data.password,
      });
      setToken(response.token);
      useAuthStore.setState({ user: response.user });
      navigate(ROUTES.DASHBOARD);
    } catch (error: any) {
      setErrorMsg(
        error.response?.data?.message || "Invalid credentials or connection error"
      );
    } finally {
      setLoading(false);
    }
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
        {/* Compact Logo inside forms */}
        <div
          style={{
            display: "inline-flex",
            alignItems: "center",
            justifyContent: "center",
            width: "48px",
            height: "48px",
            background: "linear-gradient(135deg, #0061FF 0%, #4A00E0 100%)",
            borderRadius: "10px",
            color: "#ffffff",
            fontWeight: 800,
            fontSize: "24px",
            marginBottom: "16px",
            boxShadow: "0 4px 12px rgba(0, 97, 255, 0.2)",
          }}
        >
          H
        </div>
        <h2 style={{ fontSize: "24px", fontWeight: 700, margin: "0 0 8px 0", color: "#1e293b" }}>
          Welcome Back
        </h2>
        <p style={{ margin: 0, color: "#64748b", fontSize: "14px" }}>
          Access your HR platform credentials to manage your workflow.
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
        <EmailInput name="email" control={control} />
        
        <PasswordInput name="password" control={control} />

        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            marginBottom: "24px",
          }}
        >
          <Form.Item name="rememberMe" valuePropName="checked" noStyle>
            <Checkbox style={{ fontSize: "14px", color: "#64748b" }}>Remember me</Checkbox>
          </Form.Item>
          <Link
            to={ROUTES.FORGOT_PASSWORD}
            style={{ fontSize: "14px", color: "#0061FF", fontWeight: 500 }}
          >
            Forgot Password?
          </Link>
        </div>

        <AuthButton loading={loading}>Sign In</AuthButton>
      </Form>

      <Divider style={{ margin: "24px 0" }}>
        <span style={{ color: "#94a3b8", fontSize: "13px" }}>Or sign in with SSO</span>
      </Divider>

      <div style={{ display: "flex", flexDirection: "column", gap: "12px", marginBottom: "32px" }}>
        <Button
          icon={<GoogleOutlined />}
          style={{
            height: "44px",
            borderRadius: "6px",
            fontWeight: 500,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            color: "#334155",
            border: "1px solid #e2e8f0",
          }}
          onClick={() => {}}
        >
          Continue with Google
        </Button>
        <Button
          icon={<WindowsOutlined />}
          style={{
            height: "44px",
            borderRadius: "6px",
            fontWeight: 500,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            color: "#334155",
            border: "1px solid #e2e8f0",
          }}
          onClick={() => {}}
        >
          Continue with Microsoft
        </Button>
      </div>

      {/* Security Compliance Card */}
      <div
        style={{
          background: "#f8fafc",
          border: "1px solid #e2e8f0",
          borderRadius: "8px",
          padding: "12px",
          display: "flex",
          alignItems: "flex-start",
          gap: "10px",
        }}
      >
        <SafetyCertificateOutlined style={{ color: "#0f172a", fontSize: "18px", marginTop: "2px" }} />
        <div>
          <h5 style={{ margin: "0 0 2px 0", fontSize: "13px", fontWeight: 600, color: "#1e293b" }}>
            Secure Enterprise Connection
          </h5>
          <p style={{ margin: 0, fontSize: "12px", color: "#64748b", lineHeight: "1.4" }}>
            Your connection is encrypted. Standard multi-tenant directories are compliant with SOC2 and GDPR directives.
          </p>
        </div>
      </div>
    </Card>
  );
};

export default Login;
