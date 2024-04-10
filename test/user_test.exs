defmodule Papa.UserTest do
  use Papa.DataCase
  doctest Papa

  describe "create/1" do
    test "error: email uniqueness" do
      email = Faker.Internet.email()

      insert(:user, email: email)

      {:error, changeset} =
        Papa.User.create(%{
          email: email |> String.upcase(),
          first_name: Faker.Person.first_name(),
          last_name: Faker.Person.last_name()
        })

      assert changeset.errors == [
               email:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "user_email_index"]}
             ]
    end

    test "error: first_name can't be blank" do
      {:error, changeset} =
        Papa.User.create(%{
          email: Faker.Internet.email()
        })

      assert changeset.errors == [first_name: {"can't be blank", [validation: :required]}]
    end
  end
end
