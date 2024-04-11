defmodule Papa.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Papa.Schemas.Visit

  @attributes [:first_name, :last_name, :email]
  @required_attributes [:first_name, :email]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "user" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:mintes_available, :integer)

    has_many(:visits, Visit)

    timestamps(type: :utc_datetime_usec)
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
    |> EctoCommons.EmailValidator.validate_email(:email, message: "is invalid")
    |> unique_constraint(:email)
  end
end
