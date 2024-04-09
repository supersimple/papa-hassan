defmodule Papa.Schemas.UserTest do
  use Papa.DataCase

  alias Papa.Schemas.User

  @user_fields_and_types [
    {:first_name, :string},
    {:last_name, :string},
    {:email, :string},
    {:id, :binary_id},
    {:updated_at, :utc_datetime_usec},
    {:inserted_at, :utc_datetime_usec}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(User, @user_fields_and_types)
  end
end
