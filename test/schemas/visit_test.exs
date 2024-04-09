defmodule Papa.Schemas.VisitTest do
  use Papa.DataCase

  alias Papa.Schemas.Visit

  import Papa.Factory

  @visit_fields_and_types [
    {:date, :utc_datetime_usec},
    {:id, :binary_id},
    {:inserted_at, :utc_datetime_usec},
    {:minutes, :integer},
    {:tasks, {:array, :string}},
    {:updated_at, :utc_datetime_usec},
    {:user_id, :binary_id}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Visit, @visit_fields_and_types)
  end

  test "visit factory" do
    user = insert(:user)
    visit = insert(:visit, user: user)
    expected_keys = [:date, :minutes, :tasks, :user]

    # Assert that all of the keys we expect the factory to supply contain values
    expected_keys |> Enum.all?(&refute is_nil(Map.get(visit, &1)))
  end
end
