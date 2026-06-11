import React from "react";
import { Link } from "react-router-dom";
import { Button, Result } from "antd";
import { ROUTES } from "../constants/routes";

export const NotFoundPage: React.FC = () => {
  return (
    <div
      style={{
        height: "100vh",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        background: "#f8fafc",
      }}
    >
      <Result
        status="404"
        title="404"
        subTitle="Sorry, the page you visited does not exist."
        extra={
          <Button
            type="primary"
            style={{ backgroundColor: "#0061FF", borderRadius: "6px", height: "40px" }}
          >
            <Link to={ROUTES.DASHBOARD} style={{ color: "#ffffff" }}>
              Back Home
            </Link>
          </Button>
        }
      />
    </div>
  );
};

export default NotFoundPage;
