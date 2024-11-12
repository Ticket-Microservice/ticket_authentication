defmodule Authentication.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :pwd, :string
    field :email, :string
    field :no_hp, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:email, :no_hp, :pwd])
    |> validate_required([:email, :no_hp, :pwd])
  end
end
