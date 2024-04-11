defmodule Papa.Visit do
  alias Papa.Schemas.{Transaction, Visit}

  import Ecto.Query

  def create(attrs) do
    try do
      attrs
      |> Visit.create_changeset()
      |> Papa.Repo.insert()
    rescue
      # Because there is only 1 constraint, rescuing Ecto.ConstraintError provides enough specifity
      # If we were to add more constrants, like non foreign key constraints we would want to verify
      # That it is a foreign key constraint we are running into when we rescue here and if it isn't raise it again
      _e in Ecto.ConstraintError ->
        {:error,
         attrs
         |> Visit.create_changeset()
         |> Ecto.Changeset.add_error(:member_id, "doesn't correspond to a real user")}
    end
  end

  def all_unfulfilled() do
    query =
      from(v in Visit, left_join: t in Transaction, on: t.visit_id == v.id, where: is_nil(t.id))

    Papa.Repo.all(query)
  end

  def get(id) do
    Papa.Repo.get(Visit, id)
  end
end
