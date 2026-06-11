import React from "react";
import { Button } from "antd";

interface AuthButtonProps {
  children: React.ReactNode;
  loading?: boolean;
  onClick?: () => void;
  htmlType?: "button" | "submit" | "reset";
  style?: React.CSSProperties;
}

export const AuthButton: React.FC<AuthButtonProps> = ({
  children,
  loading = false,
  onClick,
  htmlType = "submit",
  style,
}) => {
  return (
    <Button
      type="primary"
      htmlType={htmlType}
      loading={loading}
      onClick={onClick}
      style={{
        width: "100%",
        height: "44px",
        borderRadius: "6px",
        fontSize: "15px",
        fontWeight: 600,
        backgroundColor: "#0061FF",
        border: "none",
        boxShadow: "0 4px 12px rgba(0, 97, 255, 0.15)",
        ...style,
      }}
    >
      {children}
    </Button>
  );
};
