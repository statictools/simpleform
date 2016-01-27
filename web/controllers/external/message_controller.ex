defmodule Simpleform.External.MessageController do
  use Simpleform.Web, :controller

  alias Simpleform.Form

  require Logger

  #plug :scrub_params, "form" when action in [:create]

  def create(conn, form_params = %{ "id" => form_id }) do
    #changeset = Form.changeset(%Form{}, form_params)

    IO.inspect form_params

    # find the form
    case Repo.get_by(Form, public_id: form_id) do
      nil ->
        Logger.debug "Did not find the form"
        redirect(conn, to: "/")
      form ->
        # create the message in the database
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
