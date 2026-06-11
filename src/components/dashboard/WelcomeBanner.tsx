import React from "react";
import { useAuthStore } from "../../app/store/authStore";

export const WelcomeBanner: React.FC = () => {
  const user = useAuthStore((state) => state.user);
  const today = new Date().toLocaleDateString("en-US", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <div
      style={{
        background: "linear-gradient(135deg, #0061FF 0%, #60EFFF 100%)",
        borderRadius: "12px",
        padding: "24px",
        color: "#ffffff",
        marginBottom: "24px",
        boxShadow: "0 4px 15px rgba(0, 97, 255, 0.15)",
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        flexWrap: "wrap",
        gap: "16px",
      }}
    >
      <div>
        <h1 style={{ fontSize: "24px", fontWeight: 700, margin: "0 0 4px 0", color: "#ffffff" }}>
          Welcome back, {user?.name || "HR Admin"}!
        </h1>
        <p style={{ margin: 0, fontSize: "14px", color: "rgba(255, 255, 255, 0.9)" }}>
          Here's what is happening with your organization statistics today.
        </p>
      </div>
      <div style={{ textAlign: "right" }}>
        <div style={{ fontSize: "14px", fontWeight: 500, opacity: 0.95 }}>{today}</div>
        <div style={{ fontSize: "12px", opacity: 0.75 }}>System Status: Online</div>
      </div>
    </div>
  );
};
