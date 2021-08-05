defmodule Tradiex.Trading do
  @moduledoc """
  https://documentation.tradier.com/brokerage-api/trading/getting-started

  Five required parameters: class (equity, option, multileg, combo), symbol, duratin (day or gtc), side, quantity, type (market, limit, etc.)
  """

  @doc """
  Submit an equity order. Accepts options price, stop, and tag

    iex> %{"account_number" => acct} = Tradiex.Account.get_user_profile()
    iex> %{"id" => _id, "status" => status, "partner_id" => _partner_id} = Tradiex.Trading.post_order(acct, "equity", "AAPL", "buy", 1, "limit", "day", price: 10.00, tag: "example-tag")
    iex> status
    "ok"
  """
  def post_order(account_id, class, symbol, side, quantity, type, duration, options \\ []) do
    price = Keyword.get(options, :price)
    stop = Keyword.get(options, :stop)
    tag = Keyword.get(options, :tag)

    query = %{
      "class" => class,
      "symbol" => symbol,
      "side" => side,
      "quantity" => quantity,
      "type" => type,
      "duration" => duration,
      "price" => price,
      "stop" => stop,
      "tag" => tag
    }

    %{"order" => order} =
      Tradiex.request(:post, "accounts/#{account_id}/orders", URI.encode_query(query), %{})

    order
  end
end
