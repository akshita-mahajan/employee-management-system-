import React, { useState } from "react";
import { Table, Button, Row, Col, Space, Radio, notification, Avatar, Popconfirm, Tooltip } from "antd";
import { PlusOutlined, UnorderedListOutlined, AppstoreOutlined, EditOutlined, DeleteOutlined, ReloadOutlined } from "@ant-design/icons";
import type { ColumnsType } from "antd/es/table";

import { TeamStats } from "../../components/teams/TeamStats";
import { TeamCard } from "../../components/teams/TeamCard";
import { TeamFormModal } from "../../components/teams/TeamFormModal";
import { 
  useTeams, 
  useCreateTeam, 
  useUpdateTeam, 
  useDeleteTeam,
  useDepartments,
  useEmployees
} from "../../hooks/useHRMS";

interface Team {
  id: string;
  name: string;
  code: string;
  department: string;
  department_id: string;
  lead: string;
  team_lead_id: string | null;
  membersCount: number;
  membersList: string[];
  member_ids: string[];
}

const TeamPage: React.FC = () => {
  const [viewMode, setViewMode] = useState<"table" | "card">("table");
  const [modalOpen, setModalOpen] = useState(false);
  const [editingTeam, setEditingTeam] = useState<Team | null>(null);

  // Fetch teams, departments, and active employees for dynamic selection options
  const { data: dbTeams, isLoading: loading, refetch } = useTeams();
  const { data: dbDepts } = useDepartments();
  const { data: empResponse } = useEmployees({ limit: 1000 });

  const createTeamMutation = useCreateTeam();
  const updateTeamMutation = useUpdateTeam();
  const deleteTeamMutation = useDeleteTeam();

  const departments = dbDepts || [];
  const employees = empResponse?.data || [];

  const teams: Team[] = (dbTeams || []).map((t: any) => ({
    id: t.id,
    name: t.name,
    code: t.code,
    department: t.department_name || "Unassigned",
    department_id: t.department_id,
    lead: t.lead_name || "Unassigned",
    team_lead_id: t.team_lead_id,
    membersCount: parseInt(t.members_count || 0),
    membersList: t.members_list || [],
    member_ids: t.member_ids || [],
  }));

  const handleCreateOrUpdate = async (values: any) => {
    try {
      if (editingTeam) {
        await updateTeamMutation.mutateAsync({
          id: editingTeam.id,
          payload: {
            name: values.name,
            code: values.code || undefined,
            departmentId: values.departmentId,
            teamLeadId: values.teamLeadId || null,
            memberIds: values.memberIds || [],
          },
        });
        notification.success({
          message: "Team Updated",
          description: `Team ${values.name} has been updated successfully.`,
        });
      } else {
        await createTeamMutation.mutateAsync({
          name: values.name,
          code: values.code || undefined,
          departmentId: values.departmentId,
          teamLeadId: values.teamLeadId || null,
          memberIds: values.memberIds || [],
        });
        notification.success({
          message: "Team Created",
          description: `Team ${values.name} was successfully created.`,
        });
      }
      setModalOpen(false);
      setEditingTeam(null);
    } catch (err: any) {
      console.error(err);
      notification.error({
        message: "Action Failed",
        description: err.response?.data?.message || "Could not save team configuration details.",
      });
    }
  };

  const handleEditTrigger = (record: Team) => {
    setEditingTeam(record);
    setModalOpen(true);
  };

  const handleDelete = async (id: string) => {
    try {
      await deleteTeamMutation.mutateAsync(id);
      notification.success({
        message: "Team Deleted",
        description: "The team has been soft-deleted successfully.",
      });
    } catch (err) {
      console.error(err);
      notification.error({
        message: "Action Failed",
        description: "Could not remove team configuration.",
      });
    }
  };

  const totalMembers = teams.reduce((acc, curr) => acc + curr.membersCount, 0);
  const unassignedLeads = teams.filter((t) => !t.lead || t.lead === "Unassigned").length;

  const columns: ColumnsType<Team> = [
    { title: "Code", dataIndex: "code", key: "code", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
    { title: "Team Name", dataIndex: "name", key: "name", render: (text) => <span style={{ fontWeight: 600 }}>{text}</span> },
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
          <Tooltip title="Edit Team">
            <Button type="text" icon={<EditOutlined />} onClick={() => handleEditTrigger(record)} />
          </Tooltip>
          <Tooltip title="Delete Team">
            <Popconfirm
              title="Delete team?"
              description="This will soft-delete the team record."
              onConfirm={() => handleDelete(record.id)}
              okText="Yes, Delete"
              cancelText="No"
              okButtonProps={{ danger: true }}
            >
              <Button type="text" danger icon={<DeleteOutlined />} />
            </Popconfirm>
          </Tooltip>
        </Space>
      ),
    },
  ];

  return (
    <div style={{ maxWidth: "1600px", margin: "0 auto" }}>
      <Row justify="space-between" align="middle" style={{ marginBottom: "24px" }}>
        <Col>
          <h2 style={{ fontSize: "22px", fontWeight: 700, margin: 0 }}>
            Team Management
          </h2>
          <p style={{ margin: "4px 0 0 0", opacity: 0.8, fontSize: "14px" }}>
            Add, edit, or configure functional teams and assign leads.
          </p>
        </Col>
        <Col>
          <Space>
            <Button icon={<ReloadOutlined />} onClick={() => refetch()} />
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
          </Space>
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
          style={{ borderRadius: "8px", overflow: "hidden" }}
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
        departments={departments}
        employees={employees}
      />
    </div>
  );
};

export default TeamPage;
