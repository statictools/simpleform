defmodule Simpleform.MessageController do
  use Simpleform.Web, :controller

  alias Simpleform.Form
  alias Simpleform.Message

  def show(conn, %{"id" => id}) do
    message = Repo.get_by Message, id: id
    render(conn, "show.html", message: message)
  end
end
