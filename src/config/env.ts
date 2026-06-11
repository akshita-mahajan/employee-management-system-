export const env = {
  API_URL: (import.meta.env.VITE_API_URL as string) || "http://localhost:5000/api",
  NODE_ENV: (import.meta.env.MODE as string) || "development",
};
