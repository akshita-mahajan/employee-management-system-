import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "../services/api/axios";

// Query Keys
export const queryKeys = {
  employees: ["employees"] as const,
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
