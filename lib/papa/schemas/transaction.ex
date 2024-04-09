defmodule Papa.Schemas.Transaction do
  use Ecto.Schema

  alias Papa.Schemas.{User, Visit}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transaction" do
    belongs_to(:member, User, type: :binary_id, foreign_key: :member_id)
    belongs_to(:pal, User, type: :binary_id, foreign_key: :pal_id)
    belongs_to(:visit, Visit, type: :binary_id)

    timestamps(type: :utc_datetime_usec)
  end
end
