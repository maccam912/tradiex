defmodule Tradiex do
  @moduledoc """
  Documentation for `Tradiex`.
  """

  require Logger

  @endpoint Application.compile_env!(:tradiex, :endpoint)

  defp http_client() do
    Application.get_env(:tradiex, :http_client)
  end

  def request(method, endpoint, body, params) do
    url = "#{@endpoint}/#{endpoint}"

    headers = [
      {"Authorization", "Bearer #{Application.get_env(:tradiex, :token)}"},
      {"Accept", "application/json"}
    ]

    Logger.debug("Sending request to #{endpoint}")

    case http_client().request(method, url, body, headers, params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: sc, body: body}} ->
        {:error, %{"statu_code" => sc, "body" => Poison.decode!(body)}}

      _ ->
        {:error, :unknown_error}
    end
  end
end
