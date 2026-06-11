import { create } from "zustand";

export interface NotificationItem {
  id: string;
  title: string;
  message: string;
  category: "System" | "Attendance" | "Leave" | "Payroll" | "Assets" | "Employee";
  isRead: boolean;
  timestamp: string;
}

interface NotificationState {
  notifications: NotificationItem[];
  addNotification: (item: Omit<NotificationItem, "id" | "isRead" | "timestamp">) => void;
  markAsRead: (id: string) => void;
  markAllAsRead: () => void;
  getUnreadCount: () => number;
}

const mockNotifications: NotificationItem[] = [
  { id: "1", title: "New Asset Request", message: "Alice Miller requested a MacBook Pro.", category: "Assets", isRead: false, timestamp: "10 mins ago" },
  { id: "2", title: "Leave Application Received", message: "Jane Miller submitted a Sick Leave request.", category: "Leave", isRead: false, timestamp: "1 hour ago" },
  { id: "3", title: "Payroll Audit Complete", message: "May payroll compliance audit generated.", category: "Payroll", isRead: true, timestamp: "1 day ago" },
  { id: "4", title: "System Warning", message: "API Service latency peaked at 120ms.", category: "System", isRead: false, timestamp: "2 days ago" },
];

export const useNotificationStore = create<NotificationState>((set, get) => ({
  notifications: mockNotifications,
  
  addNotification: (item) => {
    const newNotif: NotificationItem = {
      id: Math.random().toString(),
      isRead: false,
      timestamp: "Just now",
      ...item,
    };
    set((state) => ({ notifications: [newNotif, ...state.notifications] }));
  },

  markAsRead: (id) => {
    set((state) => ({
      notifications: state.notifications.map((n) => (n.id === id ? { ...n, isRead: true } : n)),
    }));
  },

  markAllAsRead: () => {
    set((state) => ({
      notifications: state.notifications.map((n) => ({ ...n, isRead: true })),
    }));
  },

  getUnreadCount: () => {
    return get().notifications.filter((n) => !n.isRead).length;
  },
}));
