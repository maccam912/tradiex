defmodule TradiexTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  doctest Tradiex.MarketData
  doctest Tradiex.Account
  doctest Tradiex.Trading

  test ":ok on 200" do
    resp_body = ~s({
  "quotes": {
    "quote": [
      {
        "symbol": "AAPL",
        "description": "Apple Inc",
        "exch": "Q",
        "type": "stock",
        "last": 208.21,
        "change": -3.54,
        "volume": 25288395,
        "open": 204.29,
        "high": 208.71,
        "low": 203.5,
        "close": null,
        "bid": 208.19,
        "ask": 208.21,
        "change_percentage": -1.68,
        "average_volume": 27215269,
        "last_volume": 100,
        "trade_date": 1557168406000,
        "prevclose": 211.75,
        "week_52_high": 233.47,
        "week_52_low": 142.0,
        "bidsize": 12,
        "bidexch": "Q",
        "bid_date": 1557168406000,
        "asksize": 1,
        "askexch": "Y",
        "ask_date": 1557168406000,
        "root_symbols": "AAPL"
      },
      {
        "symbol": "VXX190517P00016000",
        "description": "VXX May 17 2019 $16.00 Put",
        "exch": "Z",
        "type": "option",
        "last": null,
        "change": null,
        "volume": 0,
        "open": null,
        "high": null,
        "low": null,
        "close": null,
        "bid": 0.0,
        "ask": 0.01,
        "underlying": "VXX",
        "strike": 16.0,
        "change_percentage": null,
        "average_volume": 0,
        "last_volume": 0,
        "trade_date": 0,
        "prevclose": null,
        "week_52_high": 0.0,
        "week_52_low": 0.0,
        "bidsize": 0,
        "bidexch": "I",
        "bid_date": 1557167321000,
        "asksize": 618,
        "askexch": "Z",
        "ask_date": 1557168367000,
        "open_interest": 10,
        "contract_size": 100,
        "expiration_date": "2019-05-17",
        "expiration_type": "standard",
        "option_type": "put",
        "root_symbol": "VXX"
      }
    ]
  }
})

    expect(HTTPoison.BaseMock, :request, fn _, _, _, _, _ ->
      {:ok, %HTTPoison.Response{status_code: 200, body: resp_body}}
    end)

    assert {:ok, %{"quotes" => %{"quote" => [%{"symbol" => "AAPL"}, %{"exch" => "Z"}]}}} =
             Tradiex.MarketData.get_quotes("AAPL")
  end
end
