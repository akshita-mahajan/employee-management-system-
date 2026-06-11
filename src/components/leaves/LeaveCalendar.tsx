import React from "react";
import { Card, Calendar, Badge } from "antd";
import type { CalendarProps } from "antd";
import type { Dayjs } from "dayjs";

interface ScheduledLeave {
  date: string;
  name: string;
  type: string;
}

const mockCalendarLeaves: ScheduledLeave[] = [
  { date: "2026-06-12", name: "Alice Miller", type: "Sick Leave" },
  { date: "2026-06-15", name: "Marcus Vance", type: "Casual Leave" },
  { date: "2026-06-16", name: "Marcus Vance", type: "Casual Leave" },
  { date: "2026-06-18", name: "David Blake", type: "Maternity/Paternity" },
];

export const LeaveCalendar: React.FC = () => {
  const dateCellRender = (value: Dayjs) => {
    const formatted = value.format("YYYY-MM-DD");
    const activeLeaves = mockCalendarLeaves.filter((l) => l.date === formatted);

    return (
      <ul style={{ listStyle: "none", padding: 0, margin: 0 }}>
        {activeLeaves.map((item, index) => (
          <li key={index}>
            <Badge status="processing" text={`${item.name} (${item.type[0]})`} />
          </li>
        ))}
      </ul>
    );
  };

  const cellRender: CalendarProps<Dayjs>["cellRender"] = (current, info) => {
    if (info.type === "date") return dateCellRender(current);
    return info.originNode;
  };

  return (
    <Card bordered={false} style={{ border: "1px solid #e2e8f0", borderRadius: "8px" }}>
      <Calendar cellRender={cellRender} />
    </Card>
  );
};
