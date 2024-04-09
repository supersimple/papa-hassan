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

      alias Papa.Repo
    end
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
end
