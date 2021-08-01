defmodule Tradiex do
  @moduledoc """
  Documentation for `Tradiex`.
  """

  require Logger

  @endpoint Application.compile_env!(:tradiex, :endpoint)
  def request(method, endpoint, body, params) do
    url = "#{@endpoint}/#{endpoint}"

    headers = [
      {"Authorization", "Bearer #{Application.get_env(:tradiex, :token)}"},
      {"Accept", "application/json"}
    ]

    Logger.debug("Sending request to #{endpoint}")

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.request(method, url, body, headers, params: params)

    Poison.decode!(body)
  end
end
