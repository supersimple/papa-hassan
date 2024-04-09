defmodule Papa.Factory do
  use ExMachina.Ecto, repo: Papa.Repo

  def user_factory do
    %Papa.Schemas.User{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.email()
    }
  end
end
