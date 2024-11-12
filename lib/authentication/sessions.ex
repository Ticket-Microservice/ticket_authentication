defmodule Authentication.Sessions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :session_data, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sessions, attrs) do
    sessions
    |> cast(attrs, [:session_data])
    |> validate_required([:session_data])
  end
end
