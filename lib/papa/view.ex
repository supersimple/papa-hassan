defmodule Papa.View do
  def changeset_error_to_human_friendly(changeset) do
    errors =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    errors
    |> Enum.map(fn {key, errors} -> "#{key} #{Enum.join(errors, ", ")}" end)
    |> Enum.join("\n")
  end

  def create_user(user) do
    Map.get(user, :id)
  end

  def request_visit(visit) do
    "visit requested on #{visit.date}"
  end

  def unfulfilled_visits(visits) do
    Enum.map(visits, &(Map.take(&1, [:id, :date, :minutes, :tasks])))
  end
end
