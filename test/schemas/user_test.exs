defmodule Papa.Schemas.UserTest do
  use Papa.DataCase

  alias Papa.Schemas.User

  @user_fields_and_types [
    {:email, :string},
    {:first_name, :string},
    {:id, :binary_id},
    {:inserted_at, :utc_datetime_usec},
    {:last_name, :string},
    {:minutes_available, :integer},
    {:updated_at, :utc_datetime_usec}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(User, @user_fields_and_types)
  end

  test "user factory" do
    user = insert(:user)

    keys = [:first_name, :last_name, :email]

    assert_map_contains_values_for_keys(user, keys)
  end
end
