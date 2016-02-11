defmodule Simpleform.FormControllerTest do
  use Simpleform.ConnCase

  import Ecto.Query

  alias Simpleform.Form
  alias Simpleform.Message
  alias Simpleform.Repo

  test "saves valid entries", %{conn: conn} do
    {:ok, form} = Form.changeset(%Form{}, %{"name" => "Zammu"}) |> Repo.insert
    conn = post conn, "/form/#{form.id}", name: "Mujju", age: 1, cuteness: 10
    assert redirected_to(conn) == "/"
    qry = from m in Message, where: m.form_id == ^form.id
    message = Repo.one(qry)
    {:ok, data} = Poison.decode(message.data)

    assert data["name"] == "Mujju"
    assert data["age"] == 1
    assert data["cuteness"] == 10
  end

  test "redirects to an error when form is not found", %{conn: conn} do
    conn = post conn, "/form/#{Ecto.UUID.generate}", name: "Mujju", age: 1, cuteness: 10
    assert redirected_to(conn) == "/error/form-notfound"
  end

end
