import app, { seedRoles } from "./app.js";

const isServerless = process.env.VERCEL === "1";

if (!isServerless) {
  const PORT = process.env.PORT || 5000;
  app.listen(PORT, async () => {
    await seedRoles();
    console.log(`Local server listening on http://localhost:${PORT}`);
  });
}

export default app;
