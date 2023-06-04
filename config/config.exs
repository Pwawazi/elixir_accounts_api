# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :account_api,
  ecto_repos: [AccountApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :account_api, AccountApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: AccountApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: AccountApi.PubSub,
  live_view: [signing_salt: System.get_env("SIGNING_SALT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#Configuration for guardian
config :account_api, AccountApiWeb.Auth.Guardian,
  issuer: "account_api",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# For Guardian DB
config :guardian, Guardian.DB,
  repo: AccountApi.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
