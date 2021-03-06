defmodule Simpleform.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:forms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

  end
end
