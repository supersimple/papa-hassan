defmodule Papa.Interface do
  alias Papa.{User, View}

  def create_user(first_name, last_name, email) do
    %{first_name: first_name, last_name: last_name, email: email}
    |> Papa.User.create()
    |> case do
      {:error, changeset} -> View.changeset_error_to_human_friendly(changeset)
      {:ok, user} -> View.create_user(user)
    end
  end
end
