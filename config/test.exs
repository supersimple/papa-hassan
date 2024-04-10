import Config

config :papa, Papa.Repo,
  database: "papa_repo",
  username: "user",
  password: "pass",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
