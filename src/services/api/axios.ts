import axios from "axios";
import { setupInterceptors } from "./interceptors";
import { env } from "../../config/env";

export const api = axios.create({
  baseURL: env.API_URL,
  withCredentials: true,
});

setupInterceptors(api);