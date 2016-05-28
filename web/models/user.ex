defmodule Simpleform.User do
  use Simpleform.Web, :model

  alias Simpleform.Repo

  schema "users" do
    field :username, :string
    field :email, :string
    field :encrypted_password, :string

    timestamps
  end

  @required_fields ~w(username email encrypted_password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def create(%{"email" => email, "password" => password}) do
    password = Comeonin.Bcrypt.hashpwsalt(password)
    Repo.insert(%Simpleform.User{
      email: email,
      encrypted_password: password,
    })
  end

  def authenticaction_valid?(email, password) do
    user = Repo.get_by(Simpleform.User, email: email)
    user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
  end

end
