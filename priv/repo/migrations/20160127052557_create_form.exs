defmodule Simpleform.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string

      timestamps
    end

  end
end
