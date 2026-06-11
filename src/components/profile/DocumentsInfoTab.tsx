import React from "react";
import { Card, Button, Tag } from "antd";
import { FilePdfOutlined, DownloadOutlined } from "@ant-design/icons";

interface DocumentItem {
  id: string;
  name: string;
  size: string;
  category: string;
}

const mockDocs: DocumentItem[] = [
  { id: "1", name: "Employment_Agreement_2026.pdf", size: "1.4 MB", category: "Agreement" },
  { id: "2", name: "National_Identity_Card.pdf", size: "820 KB", category: "ID Proof" },
  { id: "3", name: "Degree_Certificate.pdf", size: "2.1 MB", category: "Education" },
];

export const DocumentsInfoTab: React.FC = () => {
  return (
    <Card
      title={<span style={{ fontWeight: 600 }}>Employee Documents Vault</span>}
      bordered={false}
      style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}
    >
      <div style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
        {mockDocs.map((item) => (
          <div key={item.id} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "12px 0", borderBottom: "1px solid #f1f5f9" }}>
            <div style={{ display: "flex", gap: "16px", alignItems: "center" }}>
              <FilePdfOutlined style={{ fontSize: "28px", color: "#ef4444" }} />
              <div>
                <div style={{ fontWeight: 600, color: "#334155", fontSize: "14px" }}>{item.name}</div>
                <div style={{ display: "flex", gap: "8px", marginTop: "4px", alignItems: "center" }}>
                  <span style={{ fontSize: "12px", color: "#64748b" }}>{item.size}</span>
                  <span style={{ color: "#cbd5e1" }}>•</span>
                  <Tag color="blue" style={{ fontSize: "11px", lineHeight: "16px" }}>{item.category}</Tag>
                </div>
              </div>
            </div>
            <Button type="text" icon={<DownloadOutlined />} />
          </div>
        ))}
      </div>
    </Card>
  );
};
