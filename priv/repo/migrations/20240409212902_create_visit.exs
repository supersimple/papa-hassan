defmodule Papa.Repo.Migrations.CreateVisit do
  use Ecto.Migration

  def change do
    create table(:visit, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :utc_datetime
      add :minutes, :integer
      add :tasks, :binary
      add :user_id, references(:user), null: false

      timestamps()
    end
  end
end
