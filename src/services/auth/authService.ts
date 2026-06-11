import { api } from "../api/axios";
import { ENDPOINTS } from "../api/endpoints";

export const authService = {
  login: async (credentials: { email: string; password?: string }) => {
    const response = await api.post(ENDPOINTS.AUTH.LOGIN, credentials);
    return response.data;
  },
  
  getCurrentUser: async () => {
    const response = await api.get(ENDPOINTS.AUTH.ME);
    return response.data;
  },
  
  logout: async () => {
    const response = await api.post(ENDPOINTS.AUTH.LOGOUT);
    return response.data;
  }
};
