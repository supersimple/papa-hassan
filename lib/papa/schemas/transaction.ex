defmodule Papa.Schemas.Transaction do
  use Ecto.Schema

  import Ecto.Changeset

  alias Papa.Schemas.{User, Visit}

  @attributes [:member_id, :pal_id, :visit_id]
  @required_attributes [:member_id, :pal_id, :visit_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transaction" do
    belongs_to(:member, User, type: :binary_id, foreign_key: :member_id)
    belongs_to(:pal, User, type: :binary_id, foreign_key: :pal_id)
    belongs_to(:visit, Visit, type: :binary_id)

    timestamps(type: :utc_datetime_usec)
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
    |> unique_constraint(:visit_id)
  end
end
