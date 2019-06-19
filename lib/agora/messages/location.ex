defmodule Agora.Messages.Location do
  import HTTPoison
  import Poison

  def location_from_ip(ip) do
    url = "http://ip-api.com/json/#{ip}"
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        Map.drop(Poison.decode!(body), [:query, :status])

      {:ok, %{status_code: 404}} ->
        %{}

      {:error, _} ->
        %{}
    end
  end
end
