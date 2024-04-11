defmodule Papa.Transaction do
  alias Papa.Schemas.Transaction

  def create(attrs) do
    attrs
    |> Transaction.create_changeset()
    |> Papa.Repo.insert()
  end
end
