defmodule Simpleform.External.MessageController do
  use Simpleform.Web, :controller

  alias Simpleform.Form
  alias Simpleform.Message

  require Logger

  #plug :scrub_params, "form" when action in [:create]

  @filter_params ["id", "_utf8"]

  def create(conn, form_params = %{ "id" => form_id }) do
    form_params = form_params |> Map.drop(@filter_params)

    # find the form
    # TODO: do we need to find the form?
    # we could probably background this stuff
    case Repo.get_by(Form, public_id: form_id) do
      nil ->
        Logger.debug "Did not find the form"
        redirect(conn, to: "/")
      form ->
        # create the message in the database
        {_, json} = Poison.encode(form_params)
        Repo.insert(%Message{form_id: form_id, data: json})
        #Repo.insert(Message, %{form_id: form.id, data: json})

        # send a notification to the user
        Logger.debug "FOUND: #{form.name}"
        redirect(conn, to: "/")
    end

  end

end

#case Repo.insert(changeset) do
 #{:ok, _form} ->
   #conn
   #|> put_flash(:info, "Form created successfully.")
   #|> redirect(to: form_path(conn, :index))
 #{:error, changeset} ->
   #render(conn, "new.html", changeset: changeset)
   #end
