defmodule Pdf.Downloader do

  def download(link) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(link)
    File.write!("/Users/gabrielpoblete/projects/#{:os.system_time(:milli_seconds)}.pdf", body)
  end
end
