defmodule Tradiex.Account do
  @moduledoc "https://documentation.tradier.com/brokerage-api/user/get-profile"

  @doc """
  Get the user's profile (i.e. accounts)
  
    iex> %{"status" => status} = Tradiex.Account.get_user_profile()
    iex> status
    "active"
  """
  def get_user_profile() do
    %{"profile" => %{"account" => accounts}} = Tradiex.request(:get, "user/profile", "", %{})
    accounts
  end

  @doc """
  Get balances for a certain account
  
    iex> %{"account_number" => acct} = Tradiex.Account.get_user_profile()
    iex> %{"balances" => %{"total_equity" => equity}} = Tradiex.Account.get_balances(acct)
    iex> equity > 50000
    true
  """
  def get_balances(account_id) do
    Tradiex.request(:get, "accounts/#{account_id}/balances", "", %{})
  end

  @doc """
  Get positions for a certain account
  
    iex> %{"account_number" => acct} = Tradiex.Account.get_user_profile()
    iex> positions = Tradiex.Account.get_positions(acct)
    iex> positions
    %{"cost_basis" => 294.66, "date_acquired" => "2021-08-04T17:20:38.742Z", "id" => 261486, "quantity" => 2.0, "symbol" => "AAPL"}
  """
  def get_positions(account_id) do
    %{"positions" => position_structure} =
      Tradiex.request(:get, "accounts/#{account_id}/positions", "", %{})

    case position_structure do
      "null" ->
        []

      %{"position" => position_list} ->
        case position_list do
          [_item | _] = items -> items
          item -> [item]
        end
    end
  end

  @doc """
  Get orders for account
  
    iex> %{"account_number" => acct} = Tradiex.Account.get_user_profile()
    iex> orders = Tradiex.Account.get_orders(acct)
    iex> orders
    %{}
  """
  def get_orders(account_id) do
    %{"orders" => %{"order" => orders}} =
      Tradiex.request(:get, "accounts/#{account_id}/orders", "", %{})

    orders
  end
end
