defmodule Pdf.Worker do
  use GenServer

  def start_link([]) do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(data, from, state) do
    result = Pdf.Downloader.download(data)
    {:reply, [result], state}
  end
end
