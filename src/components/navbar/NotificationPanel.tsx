import React from "react";
import { List, Button, Tag, Divider, Empty } from "antd";
import { CheckOutlined, BellOutlined } from "@ant-design/icons";
import { useNotificationStore } from "../../app/store/notificationStore";

export const NotificationPanel: React.FC = () => {
  const { notifications, markAsRead, markAllAsRead } = useNotificationStore();

  const handleMarkRead = (id: string, e: React.MouseEvent) => {
    e.stopPropagation();
    markAsRead(id);
  };

  const getTagColor = (cat: string) => {
    switch (cat) {
      case "Assets": return "blue";
      case "Leave": return "orange";
      case "Payroll": return "purple";
      case "System": return "red";
      default: return "default";
    }
  };

  if (notifications.length === 0) {
    return (
      <div style={{ width: "320px", padding: "16px", textAlign: "center" }}>
        <Empty description="No notifications found" image={Empty.PRESENTED_IMAGE_SIMPLE} />
      </div>
    );
  }

  return (
    <div style={{ width: "360px", background: "#ffffff", padding: "8px 0" }}>
      <div style={{ padding: "8px 16px", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ fontWeight: 700, fontSize: "15px", color: "#1e293b" }}>Notifications</span>
        <Button type="link" size="small" onClick={markAllAsRead} style={{ fontSize: "12px", color: "#0061FF", fontWeight: 600 }}>
          Mark all as read
        </Button>
      </div>
      <Divider style={{ margin: "4px 0" }} />
      <div style={{ maxHeight: "300px", overflowY: "auto" }}>
        <List
          dataSource={notifications}
          renderItem={(item) => (
            <div
              onClick={() => markAsRead(item.id)}
              style={{
                padding: "12px 16px",
                cursor: "pointer",
                backgroundColor: item.isRead ? "#ffffff" : "#f0f7ff",
                borderBottom: "1px solid #f1f5f9",
                transition: "background 0.2s",
                display: "flex",
                gap: "12px",
                alignItems: "flex-start",
              }}
            >
              <div
                style={{
                  width: "36px",
                  height: "36px",
                  borderRadius: "50%",
                  backgroundColor: item.isRead ? "#f1f5f9" : "#e0efff",
                  color: "#0061FF",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  flexShrink: 0,
                }}
              >
                <BellOutlined />
              </div>
              <div style={{ flexGrow: 1 }}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "4px" }}>
                  <Tag color={getTagColor(item.category)} style={{ fontSize: "10px", lineHeight: "14px" }}>{item.category}</Tag>
                  <span style={{ fontSize: "11px", color: "#94a3b8" }}>{item.timestamp}</span>
                </div>
                <h5 style={{ margin: "0 0 2px 0", fontSize: "13px", fontWeight: 600, color: "#334155" }}>{item.title}</h5>
                <p style={{ margin: 0, fontSize: "12px", color: "#64748b", lineHeight: "1.4" }}>{item.message}</p>
              </div>
              {!item.isRead && (
                <Button
                  type="text"
                  shape="circle"
                  size="small"
                  icon={<CheckOutlined style={{ fontSize: "12px", color: "#0061FF" }} />}
                  onClick={(e) => handleMarkRead(item.id, e)}
                  style={{ flexShrink: 0 }}
                />
              )}
            </div>
          )}
        />
      </div>
    </div>
  );
};
