defmodule Simpleform.FormControllerTest do
  use Simpleform.ConnCase

  alias Simpleform.Form

  @form_name "zammu is awesome"

  @valid_attrs %{name: "zammu"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    changeset = Form.changeset(%Form{}, %{"name" => @form_name})
    Simpleform.Repo.insert(changeset)

    conn = get conn, form_path(conn, :index)
    assert html_response(conn, 200) =~ "Forms"
    assert html_response(conn, 200) =~ @form_name
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, form_path(conn, :new)
    assert html_response(conn, 200) =~ "New form"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, form_path(conn, :create), form: @valid_attrs
    assert redirected_to(conn) == form_path(conn, :index)
    form = Repo.get_by(Form, @valid_attrs)
    assert form != nil
    assert form.name == "zammu"
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, form_path(conn, :create), form: @invalid_attrs
    assert html_response(conn, 200) =~ "New form"
    assert (Form |> Repo.all |> Enum.count) == 0
  end

  test "shows chosen resource", %{conn: conn} do
    form = Repo.insert! %Form{name: @form_name}
    conn = get conn, form_path(conn, :show, form)
    assert html_response(conn, 200) =~ @form_name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, form_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    form = Repo.insert! %Form{name: @form_name}
    conn = get conn, form_path(conn, :edit, form)
    assert html_response(conn, 200) =~ "Edit form"
    assert html_response(conn, 200) =~ @form_name
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    form = Repo.insert! %Form{name: @form_name}
    conn = put conn, form_path(conn, :update, form), form: @valid_attrs
    assert redirected_to(conn) == form_path(conn, :show, form)
    form = Repo.get_by(Form, @valid_attrs)
    assert form.name == "zammu"
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    form = Repo.insert! %Form{name: "fooff"}
    IO.inspect form
    conn = put conn, form_path(conn, :update, form), form: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit form"
    form = Repo.get(Form, form.id)
    assert form.name == "fooff"
  end

  test "deletes chosen resource", %{conn: conn} do
    form = Repo.insert! %Form{name: @form_name}
    conn = delete conn, form_path(conn, :delete, form)
    assert redirected_to(conn) == form_path(conn, :index)
    refute Repo.get(Form, form.id)
  end
end
