defmodule AccountApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :real_deal_api,
  module: AccountApiWeb.Auth.Guardian,
  error_handler: AccountApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
