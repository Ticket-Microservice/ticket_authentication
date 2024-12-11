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

  def get_user_by_email_pwd(email, pwd) do
    user =
      Repo.one(
        from(u in Users,
          where: u.is_enabled == true and u.email == ^email
        )
      )

    case user do
      %Users{pwd: hashed_pwd} ->
        if Bcrypt.verify_pass(pwd, hashed_pwd) do
          {:ok, user}
        else
          {:error, "invalid_password"}
        end

      nil ->
        {:error, "User not found"}
    end
  end
end
