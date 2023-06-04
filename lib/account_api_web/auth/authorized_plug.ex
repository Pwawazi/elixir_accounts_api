defmodule AccountApiWeb.Auth.AuthorizedPlug do
  require Logger
  alias AccountApiWeb.Auth.ErrorResponse

  def is_authorized(%{params: %{"account" => params}} = conn, _opts) do
    if conn.assigns.account.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def is_authorized(%{params: %{"user" => params}} = conn, _opts) do
    Logger.debug "User asking for authorization is => '#{conn.assigns.account.user.id}'"
    if conn.assigns.account.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end
end
