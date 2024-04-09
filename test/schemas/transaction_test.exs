defmodule Papa.Schemas.TransactionTest do
  use Papa.DataCase

  alias Papa.Schemas.Transaction

  import Papa.Factory

  @transaction_fields_and_types [
    {:id, :binary_id},
    {:inserted_at, :utc_datetime_usec},
    {:updated_at, :utc_datetime_usec},
    {:member_id, :binary_id},
    {:pal_id, :binary_id},
    {:visit_id, :binary_id}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Transaction, @transaction_fields_and_types)
  end

  test "transaction factory" do
    member = insert(:user)
    pal = insert(:user)
    visit = insert(:visit, member: member) |> IO.inspect()
    transaction = insert(:transaction, member: member, pal: pal, visit: visit)
    expected_keys = [:member_id, :pal_id, :visit_id]

    # Assert that all of the keys we expect the factory to supply contain values
    expected_keys |> Enum.all?(&refute is_nil(Map.get(transaction, &1)))
  end
end
