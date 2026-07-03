const isLocalhost = typeof window !== "undefined" && 
  (window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1");

export const env = {
  API_URL: isLocalhost 
    ? (import.meta.env.VITE_API_URL as string) || "http://localhost:5000/api"
    : "/api",
  NODE_ENV: (import.meta.env.MODE as string) || "development",
};
