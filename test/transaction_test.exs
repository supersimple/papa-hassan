defmodule Papa.TransactionTest do
  use Papa.DataCase
  doctest Papa

  describe "create/1" do
    test "sucess: creates a transaction" do
      member = insert(:user)
      pal = insert(:user)

      visit = insert(:visit, member: member)

      Papa.Transaction.create(%{
        member_id: member.id,
        pal_id: pal.id,
        visit_id: visit.id
      })

      assert length(Repo.all(Papa.Schemas.Transaction)) === 1
    end
  end
end
