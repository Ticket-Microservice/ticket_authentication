defmodule Authentication.Schemas.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :pwd, :string
    field :email, :string
    field :no_hp, :string
    field :name, :string
    field :is_enabled, :boolean
    belongs_to :gender, Authentication.Gender

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:email, :no_hp, :pwd, :name])
    |> cast_assoc(:gender, with: &Authentication.Schemas.Gender.changeset/2)
    |> validate_required([:email, :pwd])
    |> validate_format(:email, ~r/\w*@\w*/, message: "Invalid email format")
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(changeset) do
    if changeset |> get_change(:pwd) do
      put_change(changeset, :pwd, Bcrypt.hash_pwd_salt(changeset |> get_change(:pwd)))
    else
      changeset
    end
  end
end
