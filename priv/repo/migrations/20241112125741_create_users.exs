defmodule Authentication.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :no_hp, :string
      add :pwd, :string

      timestamps(type: :utc_datetime)
    end
  end
end
