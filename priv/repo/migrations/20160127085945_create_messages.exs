defmodule Simpleform.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :data, :string
      add :form_id, :uuid

      timestamps
    end
  end
end
