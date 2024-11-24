defmodule Authentication.Repo.Migrations.CreateGenders do
  use Ecto.Migration

  def change do
    create table(:genders) do
      add :is_enabled, :boolean, default: false, null: false
      add :alter_id, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
