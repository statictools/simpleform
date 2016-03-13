defmodule Simpleform.FormView do
  use Simpleform.Web, :view

  def short_uuid(uuid) do
    # TODO: this probably not the best way to get the
    # short id, we should find a better way
    uuid |> String.split("-") |> List.first
  end

end
