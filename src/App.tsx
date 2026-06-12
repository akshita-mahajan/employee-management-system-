import { useEffect } from "react";
import { ConfigProvider, theme } from "antd";
import AppRoutes from "./app/routes/AppRoutes";
import { useUIStore } from "./app/store/uiStore";

function App() {
  const { themeMode } = useUIStore();

  useEffect(() => {
    if (themeMode === "dark") {
      document.documentElement.classList.add("dark");
      document.documentElement.style.colorScheme = "dark";
    } else {
      document.documentElement.classList.remove("dark");
      document.documentElement.style.colorScheme = "light";
    }
  }, [themeMode]);

  const customTheme = {
    algorithm: themeMode === "dark" ? theme.darkAlgorithm : theme.defaultAlgorithm,
    token: {
      colorPrimary: "#0061FF",
      colorInfo: "#0061FF",
      colorSuccess: "#52c41a",
      colorWarning: "#faad14",
      colorError: "#ff4d4f",
      borderRadius: 6,
      fontFamily: "'Outfit', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif",
    },
    components: {
      Button: {
        controlHeight: 40,
        fontWeight: 600,
      },
      Input: {
        controlHeight: 40,
      },
      Select: {
        controlHeight: 40,
      },
      Layout: {
        siderBg: themeMode === "dark" ? "#141414" : "#ffffff",
        headerBg: themeMode === "dark" ? "#141414" : "#ffffff",
        bodyBg: themeMode === "dark" ? "#0a0a0a" : "#f8fafc",
      },
    },
  };

  return (
    <ConfigProvider theme={customTheme}>
      <AppRoutes />
    </ConfigProvider>
  );
}

export default App;