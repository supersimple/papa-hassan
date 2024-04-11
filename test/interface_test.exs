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
      member = insert(:user)

      date = DateTime.utc_now()
      minutes = Faker.random_between(1, 120)
      tasks = ["Play with dog", "Friendly conversation"]

      assert "visit requested on #{date}" ==
               Interface.request_visit(
                 member.id,
                 date,
                 tasks,
                 minutes
               )

      visit = Papa.Repo.one(Papa.Schemas.Visit)

      member_id = member.id

      assert %Papa.Schemas.Visit{
               minutes: ^minutes,
               member_id: ^member_id,
               tasks: ^tasks,
               date: ^date
             } = visit
    end

    test "error" do
      minutes = Faker.random_between(1, 120)

      response =
        Interface.request_visit(
          Ecto.UUID.generate(),
          DateTime.utc_now(),
          ["Play with dog", "Friendly conversation"],
          minutes
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

      assert Papa.View.unfulfilled_visits(Enum.take(visits, -(length(visits) - 1))) ==
               Interface.unfulfilled_visits()
    end
  end

  describe "fulfill_visit/2" do
    @tag :only
    test "sucess" do
      member = insert(:user)
      pal = insert(:user)

      visit = insert(:visit, member: member)

      Interface.fulfill_visit(visit.id, pal.id)
    end
  end
end
