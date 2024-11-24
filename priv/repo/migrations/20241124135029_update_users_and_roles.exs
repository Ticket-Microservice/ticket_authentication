defmodule Authentication.Repo.Migrations.UpdateUsersAndRoles do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :surname, :string
      add :is_enabled, :boolean, default: true, null: false
      add :gender_id, references(:genders, on_delete: :nothing) # Foreign key
    end

    # 2. Add new fields to the roles table
    alter table(:roles) do
      add :is_enabled, :boolean, default: true, null: false
      add :alter_id, :bigint
    end
  end
end
