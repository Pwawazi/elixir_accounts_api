defmodule AccountApiWeb.Router do
  use AccountApiWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug AccountApiWeb.Auth.Pipeline
    plug AccountApiWeb.Auth.SetAccount
  end

  scope "/api", AccountApiWeb do
    pipe_through :api
    post "/accounts/create", AccountController, :create
    post "/accounts/sign-in", AccountController, :sign_in
  end

  scope "/api", AccountApiWeb do
    pipe_through [:api, :auth]
    get "/accounts/current-account", AccountController, :current_account
    get "/accounts/sign-out", AccountController, :sign_out
    get "/accounts/refresh-session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update
    put "/users/update", UserController, :update
  end
end
