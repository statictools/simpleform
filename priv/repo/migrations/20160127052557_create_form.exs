defmodule Simpleform.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :public_id, :uuid, default: fragment("uuid_generate_v4()")

      timestamps
    end

  end
end
