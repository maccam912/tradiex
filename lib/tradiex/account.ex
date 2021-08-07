defmodule Tradiex.Account do
  @moduledoc "https://documentation.tradier.com/brokerage-api/user/get-profile"

  @doc """
  Get the user's profile (i.e. accounts)
  """
  def get_user_profile() do
    %{"profile" => %{"account" => accounts}} = Tradiex.request(:get, "user/profile", "", %{})
    accounts
  end

  @doc """
  Get balances for a certain account
  """
  def get_balances(account_id) do
    Tradiex.request(:get, "accounts/#{account_id}/balances", "", %{})
  end

  @doc """
  Get positions for a certain account
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
  """
  def get_orders(account_id) do
    %{"orders" => %{"order" => orders}} =
      Tradiex.request(:get, "accounts/#{account_id}/orders", "", %{})

    orders
  end
end
