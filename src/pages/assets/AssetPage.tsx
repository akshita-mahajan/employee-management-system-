import React, { useState } from "react";
import { Table, Button, Row, Col, Space, Tag, notification } from "antd";
import { PlusOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { AssetStats } from "../../components/assets/AssetStats";
import { AssetFormModal } from "../../components/assets/AssetFormModal";
import { HRMSPagination } from "../../components/common/HRMSPagination";

interface Asset {
  id: string;
  name: string;
  code: string;
  category: string;
  status: "Available" | "Assigned" | "Under Repair" | "Lost" | "Retired" | string;
  value: number;
}

const mockAssets: Asset[] = [
  { id: "1", name: "MacBook Pro M3", code: "SN-MBP-001", category: "Laptop", status: "Assigned", value: 2499 },
  { id: "2", name: "Dell UltraSharp 27", code: "SN-DEL-982", category: "Monitor", status: "Available", value: 450 },
  { id: "3", name: "iPhone 15 Pro", code: "SN-IPH-105", category: "Phone", status: "Under Repair", value: 999 },
  { id: "4", name: "SIM Card T-Mobile", code: "SN-SIM-099", category: "SIM Card", status: "Available", value: 15 },
  { id: "5", name: "Slack Pro License", code: "LIC-SLA-102", category: "Software License", status: "Assigned", value: 180 },
];

const AssetPage: React.FC = () => {
  const [assets, setAssets] = useState<Asset[]>(mockAssets);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingAsset, setEditingAsset] = useState<Asset | null>(null);
  
  // Pagination State
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(5);

  const handleCreateOrUpdate = (values: any) => {
    if (editingAsset) {
      setAssets(
        assets.map((a) => (a.id === editingAsset.id ? { ...a, ...values } : a))
      );
      notification.success({
        message: "Asset Updated",
        description: `Asset ${values.name} was successfully modified.`,
      });
    } else {
      const newAsset: Asset = {
        id: (assets.length + 1).toString(),
        ...values,
      };
      setAssets([newAsset, ...assets]);
      notification.success({
        message: "Asset Registered",
        description: `Asset ${values.name} registered inside inventory.`,
      });
    }
    setModalOpen(false);
    setEditingAsset(null);
  };

  const handleEditTrigger = (record: Asset) => {
    setEditingAsset(record);
    setModalOpen(true);
  };

  const handleDelete = (id: string) => {
    setAssets(assets.filter((a) => a.id !== id));
    notification.success({
      message: "Asset Removed",
      description: "Asset was removed from inventory configuration.",
    });
  };

  const handlePageChange = (page: number, size: number) => {
    setCurrentPage(page);
    setPageSize(size);
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "Available": return "green";
      case "Assigned": return "blue";
      case "Under Repair": return "orange";
      case "Lost": return "red";
      default: return "default";
    }
  };

  const totalAssets = assets.length;
  const assigned = assets.filter((a) => a.status === "Assigned").length;
  const available = assets.filter((a) => a.status === "Available").length;
  const maintenance = assets.filter((a) => a.status === "Under Repair").length;

  // Paginated Slicing
  const paginatedAssets = assets.slice((currentPage - 1) * pageSize, currentPage * pageSize);

  const columns: ColumnsType<Asset> = [
    { title: "Serial Code", dataIndex: "code", key: "code", render: (text) => <span style={{ fontWeight: 600, color: "#475569" }}>{text}</span> },
    { title: "Asset Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600, color: "#1e293b" }}>{text}</span> },
    { title: "Category", dataIndex: "category", key: "category" },
    { title: "Value", dataIndex: "value", key: "value", render: (val) => `$${val.toLocaleString()}` },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (status: string) => <Tag color={getStatusColor(status)} style={{ fontWeight: 600 }}>{status}</Tag>,
    },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Space>
          <Button type="text" icon={<EditOutlined />} onClick={() => handleEditTrigger(record)} />
          <Button type="text" danger icon={<DeleteOutlined />} onClick={() => handleDelete(record.id)} />
        </Space>
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, color: "#1e293b", margin: 0 }}>
            Asset Inventory
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Track hardware assignments, register serial items, and audit maintenance schedules.
          </p>
        </Col>
        <Col>
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => {
              setEditingAsset(null);
              setModalOpen(true);
            }}
            style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
          >
            Register Asset
          </Button>
        </Col>
      </Row>

      {/* KPI Section */}
      <AssetStats
        total={totalAssets}
        assigned={assigned}
        available={available}
        maintenance={maintenance}
      />

      <Table
        columns={columns}
        dataSource={paginatedAssets}
        rowKey="id"
        pagination={false}
        style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
      />

      <HRMSPagination
        current={currentPage}
        pageSize={pageSize}
        total={totalAssets}
        onChange={handlePageChange}
      />

      <AssetFormModal
        open={modalOpen}
        onCancel={() => {
          setModalOpen(false);
          setEditingAsset(null);
        }}
        onSubmit={handleCreateOrUpdate}
        initialValues={editingAsset}
      />
    </div>
  );
};

export default AssetPage;
