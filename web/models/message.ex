defmodule Simpleform.Message do
  use Simpleform.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true }

  alias Simpleform.Repo
  alias Simpleform.Message

  schema "messages" do
    field :data, :string
    field :form_id, Ecto.UUID

    timestamps
  end

  @doc """
  Saves a message associated with the input form and the input data
  and returns the redirect url which can then be used to redirect the user
  """
  def save(form, message_params) do
    # we could probably background this stuff
    # create the message in the database
    # TODO: handle json errors
    {_, json} = Poison.encode(message_params)
    Repo.insert(%Message{form_id: form.id, data: json})
    #TODO: redirect the user to the redirect path
    {:ok, "/"}
  end

end
