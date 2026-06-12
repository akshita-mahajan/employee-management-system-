import type { AxiosInstance, InternalAxiosRequestConfig } from "axios";
import { useAuthStore } from "../../app/store/authStore";
import { ENDPOINTS } from "./endpoints";
import axios from "axios";

let isRefreshing = false;

type FailedQueueItem = {
  resolve: (token: string | null) => void;
  reject: (error: unknown) => void;
};

let failedQueue: FailedQueueItem[] = [];

const processQueue = (error: unknown, token: string | null = null) => {
  failedQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token);
    }
  });
  failedQueue = [];
};

export const setupInterceptors = (axiosInstance: AxiosInstance) => {
  axiosInstance.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
      const token = useAuthStore.getState().token;
      if (token && config.headers) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    },
    (error) => Promise.reject(error)
  );

  axiosInstance.interceptors.response.use(
    (response) => response,
    async (error) => {
      const originalRequest = error.config;

      // Handle 401 Unauthorized for expired tokens and attempt refresh
      if (error.response?.status === 401 && !originalRequest._retry) {
        if (originalRequest.url === ENDPOINTS.AUTH.LOGIN || originalRequest.url === ENDPOINTS.AUTH.REFRESH) {
          return Promise.reject(error);
        }

        if (isRefreshing) {
          return new Promise((resolve, reject) => {
            failedQueue.push({ resolve, reject });
          })
            .then((token) => {
              originalRequest.headers.Authorization = `Bearer ${token}`;
              return axiosInstance(originalRequest);
            })
            .catch((err) => Promise.reject(err));
        }

        originalRequest._retry = true;
        isRefreshing = true;

        try {
          // Trigger token refresh call
          const response = await axios.post(
            `${import.meta.env.VITE_API_URL || "http://localhost:5000/api"}${ENDPOINTS.AUTH.REFRESH}`,
            {},
            { withCredentials: true }
          );

          const { token } = response.data;
          useAuthStore.getState().setToken(token);

          processQueue(null, token);
          isRefreshing = false;

          originalRequest.headers.Authorization = `Bearer ${token}`;
          return axiosInstance(originalRequest);
        } catch (refreshError) {
          processQueue(refreshError, null);
          isRefreshing = false;
          useAuthStore.getState().logout();
          return Promise.reject(refreshError);
        }
      }

      return Promise.reject(error);
    }
  );
};
