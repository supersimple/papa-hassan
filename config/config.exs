import Config

config :papa,
  ecto_repos: [Papa.Repo]

config :papa, Papa.Repo,
  database: "papa_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"
