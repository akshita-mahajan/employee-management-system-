import { create } from "zustand";

interface EmployeeState {
  selectedEmployeeId: string | null;
  filters: {
    search: string;
    departmentId: string | null;
    status: string | null;
  };
  
  setSelectedEmployeeId: (id: string | null) => void;
  setFilters: (filters: Partial<EmployeeState["filters"]>) => void;
  resetFilters: () => void;
}

export const useEmployeeStore = create<EmployeeState>((set) => ({
  selectedEmployeeId: null,
  filters: {
    search: "",
    departmentId: null,
    status: null,
  },

  setSelectedEmployeeId: (id) => set({ selectedEmployeeId: id }),
  setFilters: (newFilters) =>
    set((state) => ({
      filters: { ...state.filters, ...newFilters },
    })),
  resetFilters: () =>
    set({
      filters: {
        search: "",
        departmentId: null,
        status: null,
      },
    }),
}));
