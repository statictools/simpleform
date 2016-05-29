defmodule Simpleform.SessionController do
  use Simpleform.Web, :controller
  alias Simpleform.User
  require Logger

  def new(conn, _params) do
    conn |> render(:new)
  end

  def create(conn, %{"session" => %{ "email" => email, "password" => password}}) do
    {valid, user} = User.authentication_valid?(email, password)
    if valid do
      conn
      |> Guardian.Plug.sign_in(user)
      |> redirect(to: "/")
    else
      conn |> text("Email or password is not valid")
    end
  end

  def destroy(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
