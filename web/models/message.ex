defmodule Simpleform.Message do
  use Simpleform.Web, :model

  schema "messages" do
    field :data, :string
    field :form_id, Ecto.UUID

    timestamps
  end
end
