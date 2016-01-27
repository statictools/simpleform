defmodule Simpleform.External.MessageController do
  use Simpleform.Web, :controller

  alias Simpleform.Form
  alias Simpleform.Message

  require Logger

  #plug :scrub_params, "form" when action in [:create]

  @filter_params ["id", "_utf8"]

  def create(conn, form_params = %{ "id" => form_id }) do

    message_params = form_params |> Map.drop(@filter_params)

    # find the form
    case Repo.get_by(Form, public_id: form_id) do
      nil ->
        Logger.debug "Did not find the form"
        # TODO: create a help page for users to find and debug
        # their issue, lets not silently fail the user
        redirect(conn, to: "/error/form-notfound")
      form ->
        case Message.save(form, message_params) do
          {:ok, redirect_url} -> redirect(conn, to: redirect_url)
          error_code -> redirect(conn, to: "/error/#{error_code}") #TODO: show the user a helpful message
        end
    end

  end

end
