import { Pool } from "pg"

// Portable Postgres pool: works on Neon (dev/preview) and vanilla local
// PostgreSQL (production on Ubuntu) using only DATABASE_URL.
// SSL is enabled automatically when the URL requires it (Neon), and
// disabled for localhost connections.

declare global {
  // eslint-disable-next-line no-var
  var __pgPool: Pool | undefined
}

function createPool(): Pool {
  const connectionString = process.env.DATABASE_URL
  if (!connectionString) {
    throw new Error("DATABASE_URL is not set")
  }
  const needsSsl =
    /sslmode=(require|verify-full|verify-ca|prefer)/.test(connectionString) ||
    /neon\.tech/.test(connectionString)
  return new Pool({
    connectionString,
    ssl: needsSsl ? { rejectUnauthorized: false } : undefined,
    max: 10,
  })
}

export function getPool(): Pool {
  if (!globalThis.__pgPool) {
    globalThis.__pgPool = createPool()
  }
  return globalThis.__pgPool
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function query<T = any>(text: string, params?: unknown[]): Promise<{ rows: T[]; rowCount: number }> {
  const res = await getPool().query(text, params)
  return { rows: res.rows as T[], rowCount: res.rowCount ?? 0 }
}
