defmodule Authentication.Repo.Migrations.AddUniqueConstraintToUsersEmail do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
    end

    create unique_index(:users, [:email])
  end
end
