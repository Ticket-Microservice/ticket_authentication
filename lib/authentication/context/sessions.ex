defmodule TicketAuthentications.Context.Sessions do
  alias Authentication.Schemas.Sessions
  alias Authentication.Repo
  import Ecto.Query, warn: false

  def add_session(jwt, expired) do
    {:ok, expired_time} = DateTime.from_unix(expired)
    session_attr = %{
      session_data: jwt,
      expired_at: expired_time
    }
    |> IO.inspect(label: "session")

    resp = %Sessions{}
    |> Sessions.changeset(session_attr)
    |> Repo.insert()
    |> IO.inspect()
  end
end
