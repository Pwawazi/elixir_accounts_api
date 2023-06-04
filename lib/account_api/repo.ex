defmodule AccountApi.Repo do
  require Logger
  use Ecto.Repo,
    otp_app: :account_api,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    database_url = System.get_env("DATABASE_URL")
    if database_url == nil do
      Logger.debug "The DATABASE_URL is not set, using config and the environment is: #{Mix.env()}"
      {:ok, config}
    else
      Logger.debug "Configuring database using DATABASE_URL => '#{database_url}' and the environment is: => '#{Mix.env()}'"
      {:ok, Keyword.put(config, :url, database_url)}
    end
  end
end
