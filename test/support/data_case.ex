defmodule Papa.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Papa.DataCase
      import Papa.Factory

      alias Papa.Repo
    end
  end

  setup tags do
    Papa.DataCase.setup_sandbox(tags)
    :ok
  end

  def setup_sandbox(tags) do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Papa.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
  end


  defmacro validate_schema_fields_and_types(schema, expected_schemas_and_types) do
    quote do
      test "#{unquote(schema)}: it has the correct fields and types" do
        schema = unquote(schema)
        expected_schemas_and_types = unquote(expected_schemas_and_types)

        actual_fields_with_types =
          for field <- schema.__schema__(:fields) do
            type = field_type(schema, field)

            {field, type}
          end

        assert Enum.sort(actual_fields_with_types) ==
                 Enum.sort(expected_schemas_and_types)
      end
    end
  end

  def field_type(module, field) do
    case module.__schema__(:type, field) do
      {:parameterized, Ecto.Embedded, %Ecto.Embedded{related: embedded_type}} ->
        {:embedded_schema, embedded_type}

      {:parameterized, Ecto.Enum, enum_data} ->
        {Ecto.Enum, Keyword.keys(enum_data.mappings)}

      anything_else ->
        anything_else
    end
  end

  def assert_map_contains_values_for_keys(map, keys) do
    keys |> Enum.all?(&refute is_nil(Map.get(map, &1)))
  end
end
