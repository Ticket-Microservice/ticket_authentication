defmodule TicketAuthentications.Context.Users do
  alias Authentication.Repo
  alias Authentication.Schemas.Users
  import Ecto.Query, warn: false

  def create_user(email, pwd) do
    user_attr = %{
      email: email,
      pwd: pwd,
      is_enabled: false,
      updated_at: DateTime.utc_now()
    }

    resp = %Users{}
    |> Users.changeset(user_attr)
    |> Repo.insert()
  end
end
