import { api } from "../api/axios";
import { ENDPOINTS } from "../api/endpoints";

export interface EmployeePayload {
  firstName: string;
  lastName: string;
  employeeId: string;
  email: string;
  phone?: string;
  departmentId?: string;
  department?: string;
  designation: string;
  joiningDate?: string;
  status: string;
}

export const employeeService = {
  getEmployees: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    status?: string;
    departmentId?: string;
  }) => {
    const response = await api.get(ENDPOINTS.EMPLOYEES.LIST, { params });
    return response.data;
  },

  createEmployee: async (payload: EmployeePayload) => {
    const response = await api.post(ENDPOINTS.EMPLOYEES.CREATE, payload);
    return response.data;
  },

  getDepartments: async () => {
    const response = await api.get(`${ENDPOINTS.EMPLOYEES.LIST}/departments`);
    return response.data;
  }
};
