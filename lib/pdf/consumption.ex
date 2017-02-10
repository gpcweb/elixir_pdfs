defmodule Pdf.Consumption do
  use Ecto.Schema
  import Ecto.Query

  schema "consumptions" do
    field :invoice_path
  end

  def main_query do
    from(i in Pdf.Consumption, where: ilike(i.invoice_path, ^("%https://sodimac-invoice-repository%")), select: [:invoice_path])
  end

  def all do
    Pdf.Repo.all main_query
  end

end
