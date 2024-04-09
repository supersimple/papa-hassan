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
    {:member_id, :binary_id}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Visit, @visit_fields_and_types)
  end

  test "visit factory" do
    user = insert(:user)
    visit = insert(:visit, member: user)

    keys = [:date, :minutes, :tasks, :member]

    assert_map_contains_values_for_keys(visit, keys)
  end
end
