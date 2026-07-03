import { prisma } from "../lib/prisma.js";

export const query = async (text: string, params: any[] = []) => {
  const isWriteQuery =
    text.trim().toUpperCase().startsWith("INSERT") ||
    text.trim().toUpperCase().startsWith("UPDATE") ||
    text.trim().toUpperCase().startsWith("DELETE") ||
    text.trim().toUpperCase().startsWith("ALTER");

  const normalizedParams = params || [];

  try {
    if (isWriteQuery) {
      const rowCount = await prisma.$executeRawUnsafe(text, ...normalizedParams);
      return { rows: [], rowCount };
    } else {
      const rows = await prisma.$queryRawUnsafe<any[]>(text, ...normalizedParams);
      return { rows, rowCount: rows.length };
    }
  } catch (error) {
    console.error(`Database query failed: ${text}`, error);
    throw error;
  }
};

export const getClient = async () => {
  return {
    query,
    release: () => {},
  };
};

const pool = {
  query,
  connect: getClient,
  end: async () => {
    await prisma.$disconnect();
  },
};

export default pool;
