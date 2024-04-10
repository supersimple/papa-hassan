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
  end
end
