defmodule Papa.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email, :string, collate: :nocase, null: false, unique: true

      timestamps()
    end

    create unique_index(:user, [:email])
  end
end
