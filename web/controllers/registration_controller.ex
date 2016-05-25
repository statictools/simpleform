defmodule Simpleform.RegistrationController do
  use Simpleform.Web, :controller
  alias Simpleform.Repo
  alias Simpleform.User
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"registration" => registration}) do
    Logger.info inspect(registration)

    case Repo.insert(%User{
      email: registration["email"],
      encrypted_password: Comeonin.Bcrypt.hashpwsalt(registration["password"]),
    }) do
      {:ok, user} ->
        text conn, "Inserted Yayya, #{inspect user}"
      oops ->
        text conn, "ERROR #{inspect oops}"
    end
    #render conn, "index.html"
  end
end

