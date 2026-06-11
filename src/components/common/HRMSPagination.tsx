import React from "react";
import { Pagination } from "antd";

interface HRMSPaginationProps {
  current: number;
  pageSize: number;
  total: number;
  onChange: (page: number, pageSize: number) => void;
  style?: React.CSSProperties;
}

export const HRMSPagination: React.FC<HRMSPaginationProps> = ({
  current,
  pageSize,
  total,
  onChange,
  style,
}) => {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        marginTop: "20px",
        padding: "12px 16px",
        background: "#ffffff",
        borderTop: "1px solid #e2e8f0",
        flexWrap: "wrap",
        gap: "12px",
        ...style,
      }}
    >
      <div style={{ fontSize: "14px", color: "#64748b" }}>
        Showing <strong>{Math.min((current - 1) * pageSize + 1, total)}</strong> to{" "}
        <strong>{Math.min(current * pageSize, total)}</strong> of <strong>{total}</strong> entries
      </div>
      <Pagination
        current={current}
        pageSize={pageSize}
        total={total}
        onChange={onChange}
        showSizeChanger
        pageSizeOptions={["5", "10", "20", "50"]}
      />
    </div>
  );
};
