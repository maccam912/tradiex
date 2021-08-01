defmodule Tradiex.MarketData do
  @moduledoc "https://documentation.tradier.com/brokerage-api/markets/get-quotes"

  @doc """
  Get a list of  comma-separated symbols

      iex> %{"ask" => ask} = Tradiex.MarketData.get_quotes("AAPL")
      iex> ask > 0.0
      true
  """
  def get_quotes(symbols) do
    params = %{symbols: symbols}

    %{"quotes" => %{"quote" => quotes}} = Tradiex.request(:get, "markets/quotes", "", params)
    quotes
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

  def get_historical_quotes(symbol, interval, start_date, end_date) do
    params = %{symbol: symbol, interval: interval, start: start_date, end: end_date}

    %{"history" => %{"day" => days}} = Tradiex.request(:get, "markets/history", "", params)
    days
  end

  def get_time_and_sales() do
  end

  def get_etb_securities() do
  end

  def get_clock() do
  end

  def get_calendar() do
  end

  def search_compaines() do
  end

  def lookup_symbol() do
  end

  def get_company() do
  end

  def get_corporate_calendars() do
  end

  def get_dividends() do
  end

  def get_corporate_actions() do
  end

  def get_ratios() do
  end

  def get_financial_reports() do
  end

  def get_price_statistics() do
  end
end
