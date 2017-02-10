defmodule Pdf do

  def start(_type, _args) do
    supervisor = Pdf.Supervisor.start_link
    enqueue
    supervisor
  end

  def enqueue do
    Pdf.Consumption.all
      |> Enum.each fn(c) -> spawn(fn() -> pdf_pool(c.invoice_path) end) end
  end

  defp pdf_pool(link) do
     :poolboy.transaction(
       Pdf.Supervisor.pool_name,
       fn(pid) -> :gen_server.call(pid, link) end, :infinity
     )
  end
end
