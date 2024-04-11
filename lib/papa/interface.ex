defmodule Papa.Interface do
  alias Papa.{Transaction, User, View, Visit}

  def create_user(first_name, last_name, email) do
    %{first_name: first_name, last_name: last_name, email: email}
    |> User.create()
    |> case do
      {:error, changeset} -> View.changeset_error_to_human_friendly(changeset)
      {:ok, user} -> View.create_user(user)
    end
  end

  def request_visit(user_id, date_time, tasks, minutes) do
    %{member_id: user_id, date: date_time, tasks: tasks, minutes: minutes}
    |> Visit.create()
    |> case do
      {:error, changeset} -> View.changeset_error_to_human_friendly(changeset)
      {:ok, visit} -> View.request_visit(visit)
    end
  end

  def unfulfilled_visits() do
    Visit.all_unfulfilled()
    |> View.unfulfilled_visits()
  end

  def fulfill_visit(visit_id, pal_id) do
    with {:visit, visit} when not is_nil(visit) <- {:visit, Visit.get(visit_id)} do
      Transaction.create(%{visit_id: visit.id, member_id: visit.member_id, pal_id: pal_id})
    else
      {:visit, nil} -> "Visit id is invalid"
    end
  end
end
