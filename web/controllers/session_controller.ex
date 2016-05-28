defmodule Simpleform.SessionController do
  use Simpleform.Web, :controller
  alias Simpleform.User
  require Logger

  def new(conn, _params) do
    conn |> render(:new)
  end

  def create(conn, %{"session" => %{ "email" => email, "password" => password}}) do
    if User.authenticaction_valid?(email, password) do
      conn |> text("Awesome, valid username and password.")
    else
      conn |> text("Email or password is not valid")
    end
  end
end
