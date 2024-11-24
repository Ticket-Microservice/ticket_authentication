defmodule Authentication.Schemas.User_Roles do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do

    field :user_id, :id
    field :role_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user__roles, attrs) do
    user__roles
    |> cast(attrs, [])
    |> validate_required([])
  end
end
