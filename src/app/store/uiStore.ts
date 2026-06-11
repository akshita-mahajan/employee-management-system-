import { create } from "zustand";

interface UIState {
  sidebarCollapsed: boolean;
  themeMode: "light" | "dark";
  
  toggleSidebar: () => void;
  setSidebarCollapsed: (collapsed: boolean) => void;
  setThemeMode: (mode: "light" | "dark") => void;
}

export const useUIStore = create<UIState>((set) => ({
  sidebarCollapsed: false,
  themeMode: "light",

  toggleSidebar: () => set((state) => ({ sidebarCollapsed: !state.sidebarCollapsed })),
  setSidebarCollapsed: (collapsed) => set({ sidebarCollapsed: collapsed }),
  setThemeMode: (mode) => set({ themeMode: mode }),
}));
