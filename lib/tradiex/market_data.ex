defmodule Tradiex.MarketData do
  @moduledoc "https://documentation.tradier.com/brokerage-api/markets/get-quotes"

  @doc """
  Get a list of  comma-separated symbols
  """
  def get_quotes(symbols, opts \\ []) do
    params = %{symbols: symbols, greeks: opts[:greeks] || false}

    Tradiex.request(:get, "markets/quotes", "", params)
  end

  @doc """
  Get option chain quotes, plus greeks and IV.
  Dates are YYYY-MM-DD format
  """
  def get_option_chains(symbol, expiration) do
    params = %{symbol: symbol, expiration: expiration}

    %{"options" => %{"option" => options}} =
      Tradiex.request(:get, "markets/options/chains", "", params)

    options
  end

  @doc """
  Get option chain strike prices for a certain symbol and expiration.
  Dates are YYYY-MM-DD format
  """
  def get_option_strikes(symbol, expiration) do
    params = %{symbol: symbol, expiration: expiration}

    %{"strikes" => %{"strike" => strikes}} =
      Tradiex.request(:get, "markets/options/strikes", "", params)

    strikes
  end

  @doc """
  Get expiration dates for a symbol
  """
  def get_option_expirations(symbol) do
    params = %{symbol: symbol}

    %{"expirations" => %{"date" => dates}} =
      Tradiex.request(:get, "markets/options/expirations", "", params)

    dates
  end

  @doc """
  Get options roots for an underlying symbol
  """
  def lookup_option_symbols(underlying) do
    params = %{underlying: underlying}

    %{"symbols" => symbols} = Tradiex.request(:get, "markets/options/lookup", "", params)
    symbols
  end

  @doc """
  Get historical stock data
  """
  def get_historical_quotes(symbol, interval, start_date, end_date) do
    params = %{symbol: symbol, interval: interval, start: start_date, end: end_date}

    %{"history" => %{"day" => days}} = Tradiex.request(:get, "markets/history", "", params)
    days
  end

  @doc """
  Get historical times and sales
  """
  def get_time_and_sales(symbol, interval, start_date, end_date) do
    params = %{symbol: symbol, interval: interval, start: start_date, end: end_date}

    %{"series" => %{"data" => data}} = Tradiex.request(:get, "markets/timesales", "", params)
    data
  end

  @doc """
  Easy to borrow securities. These can be shorted.
  """
  def get_etb_securities() do
    %{"securities" => %{"security" => securities}} = Tradiex.request(:get, "markets/etb", "", %{})
    securities
  end

  @doc """
  Get date, time, and market status
  """
  def get_clock() do
    %{"clock" => clock} = Tradiex.request(:get, "markets/clock", "", %{})
    clock
  end

  @doc """
  Get the market calendar
  """
  def get_calendar() do
    %{"calendar" => calendar} = Tradiex.request(:get, "markets/calendar", "", %{})
    calendar
  end

  @doc """
  Lets you search for symbols/exchanges/etc. based on a query
  """
  def search_companies(query) do
    params = %{q: query}

    %{"securities" => %{"security" => securities}} =
      Tradiex.request(:get, "markets/search", "", params)

    securities
  end

  @doc """
  Search for info about a symbol.
  """
  def lookup_symbol(query) do
    params = %{q: query}

    %{"securities" => %{"security" => securities}} =
      Tradiex.request(:get, "markets/lookup", "", params)

    securities
  end
end
