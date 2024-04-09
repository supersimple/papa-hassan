defmodule Papa.Schemas.UserTest do
  use Papa.DataCase

  alias Papa.Schemas.User

  import Papa.Factory

  @user_fields_and_types [
    {:email, :string},
    {:first_name, :string},
    {:id, :binary_id},
    {:inserted_at, :utc_datetime_usec},
    {:last_name, :string},
    {:updated_at, :utc_datetime_usec}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(User, @user_fields_and_types)
  end

  test "user factory" do
    user = insert(:user)
    expected_keys = [:first_name, :last_name, :email]

    # Assert that all of the keys we expect the factory to supply contain values
    expected_keys |> Enum.all?(&refute is_nil(Map.get(user, &1)))
  end
end
