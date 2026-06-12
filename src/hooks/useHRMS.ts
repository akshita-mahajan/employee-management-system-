import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "../services/api/axios";

// Query Keys
export const queryKeys = {
  employees: ["employees"] as const,
  employeeProfile: (id: string) => ["employees", id] as const,
  departments: ["departments"] as const,
  teams: ["teams"] as const,
  attendance: ["attendance"] as const,
  leaves: ["leaves"] as const,
  leaveBalances: (empId: string) => ["leave-balances", empId] as const,
  assets: ["assets"] as const,
  payrollRuns: ["payroll-runs"] as const,
  payslips: ["payslips"] as const,
  notifications: ["notifications"] as const,
  auditLogs: ["audit-logs"] as const,
  dashboardAnalytics: ["dashboard-analytics"] as const,
  reportDashboard: ["reports", "dashboard"] as const,
  reportPayroll: (params?: any) => ["reports", "payroll", params] as const,
  reportEmployees: (params?: any) => ["reports", "employees", params] as const,
  reportAttendance: (params?: any) => ["reports", "attendance", params] as const,
};

// 1. EMPLOYEES HOOKS
export const useEmployees = (params?: any) => {
  return useQuery({
    queryKey: [...queryKeys.employees, params],
    queryFn: async () => {
      const response = await api.get("/employees", { params });
      return response.data;
    },
  });
};

export const useEmployee = (id: string) => {
  return useQuery({
    queryKey: queryKeys.employeeProfile(id),
    queryFn: async () => {
      const response = await api.get(`/employees/${id}`);
      return response.data;
    },
    enabled: !!id,
  });
};

export const useCreateEmployee = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: any) => {
      const response = await api.post("/employees", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
    },
  });
};

export const useUpdateEmployee = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, payload }: { id: string; payload: any }) => {
      const response = await api.put(`/employees/${id}`, payload);
      return response.data;
    },
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
      queryClient.invalidateQueries({ queryKey: queryKeys.employeeProfile(variables.id) });
    },
  });
};

export const useDeleteEmployee = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.delete(`/employees/${id}`);
      return response.data;
    },
    onSuccess: (_, id) => {
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
      queryClient.invalidateQueries({ queryKey: queryKeys.employeeProfile(id) });
    },
  });
};

export const useRestoreEmployee = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.post(`/employees/${id}/restore`);
      return response.data;
    },
    onSuccess: (_, id) => {
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
      queryClient.invalidateQueries({ queryKey: queryKeys.employeeProfile(id) });
    },
  });
};

// 2. DEPARTMENTS HOOKS
export const useDepartments = () => {
  return useQuery({
    queryKey: queryKeys.departments,
    queryFn: async () => {
      const response = await api.get("/departments");
      return response.data;
    },
  });
};

export const useCreateDepartment = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: any) => {
      const response = await api.post("/departments", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.departments });
    },
  });
};

export const useUpdateDepartment = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, payload }: { id: string; payload: any }) => {
      const response = await api.put(`/departments/${id}`, payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.departments });
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
    },
  });
};

export const useDeleteDepartment = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.delete(`/departments/${id}`);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.departments });
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
    },
  });
};

export const useRestoreDepartment = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.post(`/departments/${id}/restore`);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.departments });
      queryClient.invalidateQueries({ queryKey: queryKeys.employees });
    },
  });
};

// 3. TEAMS HOOKS
export const useTeams = () => {
  return useQuery({
    queryKey: queryKeys.teams,
    queryFn: async () => {
      const response = await api.get("/teams");
      return response.data;
    },
  });
};

export const useCreateTeam = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: any) => {
      const response = await api.post("/teams", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.teams });
    },
  });
};

export const useUpdateTeam = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, payload }: { id: string; payload: any }) => {
      const response = await api.put(`/teams/${id}`, payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.teams });
    },
  });
};

export const useDeleteTeam = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.delete(`/teams/${id}`);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.teams });
    },
  });
};

export const useRestoreTeam = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.post(`/teams/${id}/restore`);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.teams });
    },
  });
};

// 4. ATTENDANCE HOOKS
export const useAttendance = () => {
  return useQuery({
    queryKey: queryKeys.attendance,
    queryFn: async () => {
      const response = await api.get("/attendance");
      return response.data;
    },
  });
};

export const useCheckIn = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: { employeeId: string; date?: string; status?: string }) => {
      const response = await api.post("/attendance/checkin", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.attendance });
    },
  });
};

// 5. LEAVES HOOKS
export const useLeaves = () => {
  return useQuery({
    queryKey: queryKeys.leaves,
    queryFn: async () => {
      const response = await api.get("/leaves");
      return response.data;
    },
  });
};

export const useLeaveBalances = (employeeId: string) => {
  return useQuery({
    queryKey: queryKeys.leaveBalances(employeeId),
    queryFn: async () => {
      const response = await api.get(`/leaves/balances/${employeeId}`);
      return response.data;
    },
    enabled: !!employeeId,
  });
};

export const useApplyLeave = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: any) => {
      const response = await api.post("/leaves", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.leaves });
    },
  });
};

export const useUpdateLeaveStatus = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, status, approvedBy }: { id: string; status: string; approvedBy?: string }) => {
      const response = await api.put(`/leaves/${id}/status`, { status, approvedBy });
      return response.data;
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: queryKeys.leaves });
      queryClient.invalidateQueries({ queryKey: queryKeys.leaveBalances(data.employee_id) });
    },
  });
};

// 6. ASSETS HOOKS
export const useAssets = () => {
  return useQuery({
    queryKey: queryKeys.assets,
    queryFn: async () => {
      const response = await api.get("/assets");
      return response.data;
    },
  });
};

export const useCreateAsset = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: any) => {
      const response = await api.post("/assets", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.assets });
    },
  });
};

export const useAssignAsset = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, employeeId, notes }: { id: string; employeeId: string; notes?: string }) => {
      const response = await api.post(`/assets/${id}/assign`, { employeeId, notes });
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.assets });
    },
  });
};

export const useReturnAsset = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const response = await api.post(`/assets/${id}/return`);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.assets });
    },
  });
};

// 7. PAYROLL HOOKS
export const usePayrollRuns = () => {
  return useQuery({
    queryKey: queryKeys.payrollRuns,
    queryFn: async () => {
      const response = await api.get("/payroll/runs");
      return response.data;
    },
  });
};

export const usePayslips = () => {
  return useQuery({
    queryKey: queryKeys.payslips,
    queryFn: async () => {
      const response = await api.get("/payroll/payslips");
      return response.data;
    },
  });
};

// 8. NOTIFICATIONS HOOKS
export const useNotifications = () => {
  return useQuery({
    queryKey: queryKeys.notifications,
    queryFn: async () => {
      const response = await api.get("/notifications");
      return response.data;
    },
  });
};

// 9. AUDIT LOGS HOOKS
export const useAuditLogs = () => {
  return useQuery({
    queryKey: queryKeys.auditLogs,
    queryFn: async () => {
      const response = await api.get("/audit-logs");
      return response.data;
    },
  });
};

// 10. DASHBOARD ANALYTICS HOOK
export const useDashboardAnalytics = (params?: any) => {
  return useQuery({
    queryKey: [queryKeys.dashboardAnalytics, params],
    queryFn: async () => {
      const response = await api.get("/dashboard/analytics", { params });
      return response.data;
    },
  });
};

// 11. REPORTS HOOKS
export const useReportDashboard = () => {
  return useQuery({
    queryKey: queryKeys.reportDashboard,
    queryFn: async () => {
      const response = await api.get("/reports/dashboard");
      return response.data;
    },
  });
};

export const useReportPayroll = (params?: any) => {
  return useQuery({
    queryKey: queryKeys.reportPayroll(params),
    queryFn: async () => {
      const response = await api.get("/reports/payroll", { params });
      return response.data;
    },
  });
};

export const useReportEmployees = (params?: any) => {
  return useQuery({
    queryKey: queryKeys.reportEmployees(params),
    queryFn: async () => {
      const response = await api.get("/reports/employees", { params });
      return response.data;
    },
  });
};

export const useReportAttendance = (params?: any) => {
  return useQuery({
    queryKey: queryKeys.reportAttendance(params),
    queryFn: async () => {
      const response = await api.get("/reports/attendance", { params });
      return response.data;
    },
  });
};

export const useGenerateReport = () => {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (payload: { name: string; category: string; fileFormat: string; scope?: string }) => {
      const response = await api.post("/reports/generate", payload);
      return response.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.reportDashboard });
    },
  });
};
