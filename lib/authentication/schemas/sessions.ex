defmodule Authentication.Schemas.Sessions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :session_data, :string
    belongs_to :users, Authentication.Schemas.Users
    field :expired_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sessions, attrs) do
    sessions
    |> cast(attrs, [:session_data, :expired_at, :users_id])
    # |> cast_assoc(:users, with: &Authentication.Schemas.Users.changeset/2)
    |> validate_required([:session_data, :expired_at, :users_id])
    |> hash_password(:session_data)
  end

  defp hash_password(changeset, field) do
    if changeset |> get_change(field) do
      put_change(changeset, field, Bcrypt.hash_pwd_salt(changeset |> get_change(field)))
    else
      changeset
    end
  end
end
