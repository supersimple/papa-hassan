defmodule Papa.Interface do
  alias Papa.{Transaction, User, View, Visit}
  alias Papa.Schemas

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
    with {:visit, visit} when not is_nil(visit) <- {:visit, Visit.get(visit_id)},
         # This check should occur at the DB level not application level, SQLite or the Ecto Adapter appears to have issues with
         # unique foreign keys
         {:transaction, transaction} when is_nil(transaction) <-
           {:transaction, Transaction.get_by_visit_id(visit_id)},
         {:same, false} <- {:same, visit.member_id === pal_id},
         {:pal, pal} when not is_nil(pal) <- {:pal, User.get(pal_id)},
         # Member existence should be enforced at the database level, if there's a visit with a member_id
         # Then that member better exist!
         member = User.get(visit.member_id),
         {:enough_minutes, true} <- {:enough_minutes, member.minutes_available >= visit.minutes} do
      transaction_changeset =
        Schemas.Transaction.create_changeset(%{
          visit_id: visit.id,
          member_id: visit.member_id,
          pal_id: pal_id
        })

      pal_changeset =
        Schemas.User.update_changeset(pal, %{
          minutes_available: pal.minutes_available + floor(visit.minutes * 0.85)
        })

      member_changeset =
        Schemas.User.update_changeset(member, %{
          minutes_available: member.minutes_available - visit.minutes
        })

      case Ecto.Multi.new()
           |> Ecto.Multi.insert(:transaction, transaction_changeset)
           |> Ecto.Multi.update(:pal, pal_changeset)
           |> Ecto.Multi.update(:member, member_changeset)
           |> Papa.Repo.transaction() do
        {:ok, _} ->
          "Success"

        {:error, _} ->
          # We can get more granular errors here if we wanted!
          "Error fulfilling visit"
      end
    else
      # This should arguably be the responsibility of the view
      {:transaction, _transaction} ->
        "visit has already been fulfilled"

      {:visit, nil} ->
        "visit_id is invalid"

      {:same, true} ->
        "cannot fulfill your own visit request"

      {:pal, nil} ->
        "pal_id is invalid"

      {:enough_minutes, false} ->
        "member does not have enough minutes"
    end
  end
end
