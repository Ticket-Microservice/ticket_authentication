defmodule Authentication.Repo.Migrations.AddUniqueIdInRoleGender do
  use Ecto.Migration

  def change do
    create unique_index(:genders, [:name])
    create unique_index(:roles, [:name])
  end
end
