defmodule TicketAuthentications.Context.Sessions do
  alias Authentication.Schemas.Sessions
  alias Authentication.Repo
  import Ecto.Query, warn: false

  def add_session(jwt, expired, user_id) do
    {:ok, expired_time} = DateTime.from_unix(expired)
    session_attr = %{
      session_data: jwt,
      expired_at: expired_time,
      users_id: user_id
    }
    |> IO.inspect(label: "session")

    resp = %Sessions{}
    |> Sessions.changeset(session_attr)
    |> Repo.insert()
    |> IO.inspect()
  end

  def check_token(user_id, jwt_param) do
    current_datetime = DateTime.utc_now()
    tokens = Repo.all(
      from(sess in "sessions",
            select: %{jwt: sess.session_data, expired_at: sess.expired_at},
            where: sess.users_id == ^user_id and sess.expired_at > ^current_datetime
      )
    )
    |> IO.inspect(label: "token")

    is_valid = Enum.any?(tokens, fn token ->
      Bcrypt.verify_pass(jwt_param, token.jwt)
    end)
  end
end
