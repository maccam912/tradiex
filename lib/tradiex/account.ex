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
    iex> equity
    1.0e5
  """
  def get_balances(account_id) do
    Tradiex.request(:get, "accounts/#{account_id}/balances", "", %{})
  end
end
