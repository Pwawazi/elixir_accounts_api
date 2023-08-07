defmodule AccountApiWeb.AccountJSON do
  require Logger
  alias AccountApi.{Accounts.Account}
  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hashed_password: account.hashed_password
    }
  end

  def render("account_token.json", %{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

  def render("full_account.json", %{account: account}) do
    %{
      id: account.id,
      user_id: account.user.id,
      email: account.email,
      first_name: account.user.first_name,
      last_name: account.user.last_name
    }

    # Users.get_user_by_account_id(account.id)

  end
end
