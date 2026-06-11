import React from "react";
import { Link, useLocation } from "react-router-dom";
import { Breadcrumb } from "antd";

export const BreadcrumbSystem: React.FC = () => {
  const location = useLocation();
  const pathnames = location.pathname.split("/").filter((x) => x);

  const breadcrumbItems = [
    {
      title: <Link to="/">Home</Link>,
    },
    ...pathnames.map((name, index) => {
      const routeTo = `/${pathnames.slice(0, index + 1).join("/")}`;
      const isLast = index === pathnames.length - 1;
      const formattedName = name.charAt(0).toUpperCase() + name.slice(1).replace("-", " ");

      return {
        title: isLast ? (
          <span style={{ color: "#1e293b", fontWeight: 600 }}>{formattedName}</span>
        ) : (
          <Link to={routeTo}>{formattedName}</Link>
        ),
      };
    }),
  ];

  return (
    <Breadcrumb
      items={breadcrumbItems}
      style={{
        fontSize: "14px",
      }}
    />
  );
};
