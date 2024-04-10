defmodule Papa.Schemas.TransactionTest do
  use Papa.DataCase

  alias Papa.Schemas.Transaction

  @transaction_fields_and_types [
    {:id, :binary_id},
    {:inserted_at, :utc_datetime_usec},
    {:member_id, :binary_id},
    {:pal_id, :binary_id},
    {:updated_at, :utc_datetime_usec},
    {:visit_id, :binary_id}
  ]

  describe "fields and types" do
    validate_schema_fields_and_types(Transaction, @transaction_fields_and_types)
  end

  test "transaction factory" do
    member = insert(:user)
    pal = insert(:user)
    visit = insert(:visit, member: member)
    transaction = insert(:transaction, member: member, pal: pal, visit: visit)

    keys = [:member_id, :pal_id, :visit_id]

    assert_map_contains_values_for_keys(transaction, keys)
  end
end
