defmodule Simpleform.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :data, :string
      add :form_id, :uuid

      timestamps
    end
  end
end
