defmodule Papa.Schemas.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    # has_many :visits, Visit

    timestamps([type: :utc_datetime_usec])
  end
end
