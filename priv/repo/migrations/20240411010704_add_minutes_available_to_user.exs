defmodule Papa.Repo.Migrations.AddMinutesAvailableToUser do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :minutes_available, :integer, default: 120
    end
  end
end
