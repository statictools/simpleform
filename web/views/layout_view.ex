defmodule Simpleform.LayoutView do
  use Simpleform.Web, :view

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def user_signed_in?(conn) do
    !!current_user(conn)
  end
end
