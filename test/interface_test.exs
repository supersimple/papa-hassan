defmodule Papa.InterfaceTest do
  use Papa.DataCase

  alias Papa.Interface
  alias Papa.Schemas.User

  describe "create_user/3" do
    test "sucess" do
      {:ok, %User{id: id}} =
        Interface.create_user(
          Faker.Person.first_name(),
          Faker.Person.last_name(),
          Faker.Internet.email()
        )
    end

    test "error" do
      "email is invalid" =
        Interface.create_user(
          Faker.Person.first_name(),
          Faker.Person.last_name(),
          "invalid_email"
        )
    end
  end
end
