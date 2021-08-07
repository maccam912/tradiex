defmodule TradiexTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  doctest Tradiex.MarketData
  doctest Tradiex.Account
  doctest Tradiex.Trading

  test ":ok on 200" do
    expect(HTTPoison.BaseMock, :request, fn _ -> {:ok, "abc"} end)

    assert {:ok, _} = Tradiex.MarketData.get_quotes("AAPL")
  end
end
