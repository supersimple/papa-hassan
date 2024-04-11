defmodule Papa.VisitTest do
  use Papa.DataCase
  doctest Papa

  describe "all_unfulfilled/0" do
    test "sucess: returns all unfulfilled visits" do
      member = insert(:user)
      pal = insert(:user)

      visits = insert_list(5, :visit, member: member)

      insert(:transaction, visit: hd(visits), member: member, pal: pal)

      assert Papa.Visit.all_unfulfilled() |> length === length(visits) - 1
    end
  end
end
