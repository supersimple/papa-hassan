defmodule Papa.User do
  alias Papa.Schemas.User

  def create(attrs) do
    attrs
    |> User.create_changeset()
    |> Papa.Repo.insert()
  end
end
