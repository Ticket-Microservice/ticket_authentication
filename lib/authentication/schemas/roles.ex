defmodule Authentication.Schemas.Roles do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :is_enabled, :boolean, default: true
    field :alter_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:name, :is_enabled, :alter_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
