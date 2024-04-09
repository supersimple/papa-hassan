defmodule Papa.Schemas.Visit do
  use Ecto.Schema

  alias Papa.Schemas.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "visit" do
    field(:date, :utc_datetime_usec)
    field(:minutes, :integer)
    field(:tasks, {:array, :string})

    belongs_to(:user, User, type: :binary_id)

    timestamps(type: :utc_datetime_usec)
  end
end
