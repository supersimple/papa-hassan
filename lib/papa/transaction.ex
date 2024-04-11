defmodule Papa.Transaction do
  alias Papa.Schemas.Transaction

  def get_by_visit_id(visit_id) do
    Papa.Repo.get_by(Transaction, visit_id: visit_id)
  end
end
