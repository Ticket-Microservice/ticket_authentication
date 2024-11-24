defmodule Authentication.Gender do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genders" do
    field :name, :string
    field :is_enabled, :boolean, default: false
    field :alter_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(gender, attrs) do
    gender
    |> cast(attrs, [:is_enabled, :alter_id, :name])
    |> validate_required([:is_enabled, :alter_id, :name])
  end
end
