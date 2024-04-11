defmodule Papa.Schemas.Visit do
  use Ecto.Schema

  import Ecto.Changeset

  alias Papa.Schemas.{Transaction, User}

  @attributes [:date, :minutes, :tasks, :member_id]
  @required_attributes [:date, :member_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "visit" do
    field(:date, :utc_datetime_usec)
    field(:minutes, :integer)
    field(:tasks, {:array, :string})

    belongs_to(:member, User, type: :binary_id, foreign_key: :member_id)

    has_one(:transaction, Transaction)

    timestamps(type: :utc_datetime_usec)
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
  end
end
