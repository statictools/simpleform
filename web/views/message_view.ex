defmodule Simpleform.MessageView do
  use Simpleform.Web, :view

  # TODO: this is duplicated in the form_view
  def short_uuid(uuid) do
    uuid |> String.split("-") |> List.first
  end
end
