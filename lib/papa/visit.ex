defmodule Papa.Visit do
  alias Papa.Schemas.Visit

  def create(attrs) do
    attrs
    |> Visit.create_changeset()
    |> Papa.Repo.insert()
  end
end
