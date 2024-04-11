defmodule Papa.InterfaceTest do
  use Papa.DataCase

  alias Papa.Interface

  describe "create_user/3" do
    test "sucess" do
      id =
        Interface.create_user(
          Faker.Person.first_name(),
          Faker.Person.last_name(),
          Faker.Internet.email()
        )

      assert is_binary(id)
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

  describe "request_visit/3" do
    test "sucess" do
      user = insert(:user)

      time = DateTime.utc_now()

      assert "visit requested on #{time}" ==
               Interface.request_visit(
                 user.id,
                 time,
                 ["Play with dog", "Friendly conversation"]
               )
    end

    test "error" do
      response =
        Interface.request_visit(
          Ecto.UUID.generate(),
          DateTime.utc_now(),
          ["Play with dog", "Friendly conversation"]
        )

      assert response == "member_id doesn't correspond to a real user"
    end
  end

  describe "unfulfilled_visits/0" do
    test "sucess" do
      member = insert(:user)
      pal = insert(:user)

      visits = insert_list(5, :visit, member: member)

      insert(:transaction, visit: hd(visits), member: member, pal: pal)

      assert Papa.View.unfulfilled_visits(Enum.take(visits, -(length(visits) - 1)))  ==
               Interface.unfulfilled_visits()
    end
  end
end
