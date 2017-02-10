defmodule Pdf.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    poolboy_config = [
      {:name, {:local, pool_name()}},
      {:worker_module, Pdf.Worker},
      {:size, 2},
      {:max_overflow, 0}
    ]

    children = [
      :poolboy.child_spec(pool_name(), poolboy_config, []),
      worker(Pdf.Repo, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

  def pool_name() do
    :pdf_pool
  end
end
