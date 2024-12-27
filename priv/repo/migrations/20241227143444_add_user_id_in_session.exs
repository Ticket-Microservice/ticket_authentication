defmodule Authentication.Repo.Migrations.AddUserIdInSession do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      add :expired_at, :naive_datetime
    end
  end
end
