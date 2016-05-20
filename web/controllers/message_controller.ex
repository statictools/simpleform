defmodule Simpleform.MessageController do
  use Simpleform.Web, :controller

  alias Simpleform.Form
  alias Simpleform.Message

  def show(conn, %{"id" => id}) do
    message = Repo.get_by Message, id: id
    render(conn, "show.html", message: message)
  end

  def index(conn, %{"form_id" => form_id}) do
    messages = Repo.all(from m in Message, select: m, where: m.form_id == ^form_id)
    json conn, messages
  end
end
