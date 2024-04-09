defmodule Papa.Factory do
  use ExMachina.Ecto, repo: Papa.Repo

  def user_factory do
    %Papa.Schemas.User{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.email()
    }
  end

  def visit_factory do
    %Papa.Schemas.Visit{
      minutes: Faker.random_between(0, 120),
      date: Faker.DateTime.backward(1_000),
      tasks: ["Abc", "123"]
    }
  end

  def transaction_factory do
    %Papa.Schemas.Transaction{}
  end
end
