defmodule Papa.Interface do
  alias Papa.Schemas.User
  alias Papa.View

  def create_user(first_name, last_name, email) do
    %{first_name: first_name, last_name: last_name, email: email}
    |> User.create_changeset()
    |> Papa.Repo.insert()
    |> case do
      {:error, error} -> View.changeset_error_to_human_friendly(error)
      other -> other
    end
  end
end
