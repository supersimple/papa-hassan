defmodule Papa.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :member_id, references(:user), null: false
      add :pal_id, references(:user), null: false
      add :visit_id, references(:visit), null: false, unique: true

      timestamps()
    end
  end
end
