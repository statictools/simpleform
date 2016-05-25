defmodule Simpleform.SessionController do
  use Simpleform.Web, :controller

  def new(conn, _params) do
    conn |> render(:new)
  end

  def create(conn, %{"session" => %{ "email" => email, "password" => password}}) do
    conn |> text("Acc")
  end
end
