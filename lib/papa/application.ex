defmodule Papa.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Papa.Repo
    ]

    opts = [strategy: :one_for_one, name: Papa.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
