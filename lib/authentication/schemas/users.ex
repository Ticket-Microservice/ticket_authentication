defmodule Authentication.Schemas.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :pwd, :string
    field :email, :string
    field :no_hp, :string
    field :is_enabled, :boolean
    belongs_to :gender, Authentication.Gender

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:email, :no_hp, :pwd])
    |> validate_required([:email, :pwd])
    |> validate_format(:email, ~r/\w*@\w*/, message: "Invalid email format")
  end
end
