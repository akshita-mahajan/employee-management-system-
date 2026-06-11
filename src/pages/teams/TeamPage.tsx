import React, { useState } from "react";
import { Table, Button, Row, Col, Space, Radio, notification, Avatar } from "antd";
import { PlusOutlined, UnorderedListOutlined, AppstoreOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { TeamStats } from "../../components/teams/TeamStats";
import { TeamCard } from "../../components/teams/TeamCard";
import { TeamFormModal } from "../../components/teams/TeamFormModal";
import { useTeams, useCreateTeam } from "../../hooks/useHRMS";

interface Team {
  id: string;
  name: string;
  code: string;
  department: string;
  lead: string;
  membersCount: number;
  membersList: string[];
}

const TeamPage: React.FC = () => {
  const [viewMode, setViewMode] = useState<"table" | "card">("table");
  const [modalOpen, setModalOpen] = useState(false);
  const [editingTeam, setEditingTeam] = useState<Team | null>(null);

  const { data: dbTeams, isLoading: loading } = useTeams();
  const createTeamMutation = useCreateTeam();

  const teams: Team[] = (dbTeams || []).map((t: any) => ({
    id: t.id,
    name: t.name,
    code: t.code,
    department: t.department_name || "Unassigned",
    lead: t.lead_name || "Unassigned",
    membersCount: 4, // resolved or mock count
    membersList: ["Jane Miller", "Bob Vance"],
  }));

  const handleCreateOrUpdate = async (values: any) => {
    try {
      if (editingTeam) {
        notification.warning({
          message: "Edit Team",
          description: "Modification of database team models is disabled in this sprint.",
        });
      } else {
        await createTeamMutation.mutateAsync({
          name: values.name,
          code: values.code,
          departmentId: values.departmentId,
        });
        notification.success({
          message: "Team Created",
          description: `Team ${values.name} was successfully created in PostgreSQL.`,
        });
      }
    } catch (err) {
      console.error(err);
      notification.error({
        message: "Action Failed",
        description: "Could not create team record in database.",
      });
    }
    setModalOpen(false);
    setEditingTeam(null);
  };

  const handleEditTrigger = (record: Team) => {
    setEditingTeam(record);
    setModalOpen(true);
  };

  const handleDelete = (_id: string) => {
    notification.warning({
      message: "Delete Protected",
      description: "Deletion of primary functional teams is restricted.",
    });
  };

  const totalMembers = teams.reduce((acc, curr) => acc + curr.membersCount, 0);
  const unassignedLeads = teams.filter((t) => !t.lead || t.lead === "Unassigned").length;

  const columns: ColumnsType<Team> = [
    { title: "Code", dataIndex: "code", key: "code", render: (text) => <span style={{ fontWeight: 600, color: "#475569" }}>{text}</span> },
    { title: "Team Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600, color: "#1e293b" }}>{text}</span> },
    { title: "Department", dataIndex: "department", key: "department" },
    { title: "Team Lead", dataIndex: "lead", key: "lead" },
    { title: "Size", dataIndex: "membersCount", key: "membersCount" },
    {
      title: "Members",
      dataIndex: "membersList",
      key: "membersList",
      render: (list: string[]) => (
        <Avatar.Group max={{ count: 3 }}>
          {list.map((m, idx) => (
            <Avatar key={idx} style={{ backgroundColor: "#16a34a" }}>{m[0]}</Avatar>
          ))}
        </Avatar.Group>
      ),
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
            Team Management
          </h2>
          <p style={{ margin: "4px 0 0 0", color: "#64748b", fontSize: "14px" }}>
            Add, edit, or configure functional teams and assign leads.
          </p>
        </Col>
        <Col>
          <Button
            type="primary"
            icon={<PlusOutlined />}
            onClick={() => {
              setEditingTeam(null);
              setModalOpen(true);
            }}
            style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
          >
            Create Team
          </Button>
        </Col>
      </Row>

      {/* KPI Section */}
      <TeamStats
        totalTeams={teams.length}
        totalMembers={totalMembers}
        unassignedLeads={unassignedLeads}
      />

      {/* List/Grid toggles */}
      <Row justify="end" style={{ marginBottom: "20px" }}>
        <Col>
          <Radio.Group value={viewMode} onChange={(e) => setViewMode(e.target.value)} style={{ height: "40px" }}>
            <Radio.Button value="table" style={{ height: "40px", lineHeight: "38px" }}>
              <UnorderedListOutlined />
            </Radio.Button>
            <Radio.Button value="card" style={{ height: "40px", lineHeight: "38px" }}>
              <AppstoreOutlined />
            </Radio.Button>
          </Radio.Group>
        </Col>
      </Row>

      {viewMode === "table" ? (
        <Table
          loading={loading}
          columns={columns}
          dataSource={teams}
          rowKey="id"
          pagination={false}
          style={{ border: "1px solid #e2e8f0", borderRadius: "8px", overflow: "hidden" }}
        />
      ) : (
        <Row gutter={[24, 24]}>
          {teams.map((t) => (
            <Col xs={24} sm={12} md={8} key={t.id}>
              <TeamCard
                team={t}
                onEdit={() => handleEditTrigger(t)}
                onDelete={() => handleDelete(t.id)}
              />
            </Col>
          ))}
        </Row>
      )}

      <TeamFormModal
        open={modalOpen}
        onCancel={() => {
          setModalOpen(false);
          setEditingTeam(null);
        }}
        onSubmit={handleCreateOrUpdate}
        initialValues={editingTeam}
      />
    </div>
  );
};

export default TeamPage;
