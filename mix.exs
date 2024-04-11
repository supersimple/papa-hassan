defmodule Papa.MixProject do
  use Mix.Project

  def project do
    [
      app: :papa,
      version: "0.1.0",
      elixir: "~> 1.16-rc",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Papa.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_commons, "~> 0.3.4"},
      {:ecto_sql, "~> 3.0"},
      {:ecto_sqlite3, "~> 0.13"},
      {:ex_machina, "~> 2.7.0", only: :test},
      {:faker, "~> 0.18", only: :test},
      {:jason, "~> 1.4"}
    ]
  end
end
