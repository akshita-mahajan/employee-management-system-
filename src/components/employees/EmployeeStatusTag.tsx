import React from "react";
import { Tag } from "antd";

interface EmployeeStatusTagProps {
  status: "ACTIVE" | "INACTIVE" | "TERMINATED" | "ON_LEAVE" | string;
}

export const EmployeeStatusTag: React.FC<EmployeeStatusTagProps> = ({ status }) => {
  let color = "blue";
  let text = status;

  switch (status) {
    case "ACTIVE":
      color = "green";
      text = "Active";
      break;
    case "INACTIVE":
      color = "default";
      text = "Inactive";
      break;
    case "ON_LEAVE":
      color = "orange";
      text = "On Leave";
      break;
    case "TERMINATED":
      color = "red";
      text = "Terminated";
      break;
  }

  return (
    <Tag color={color} style={{ fontWeight: 600, borderRadius: "4px" }}>
      {text}
    </Tag>
  );
};
