defmodule TicketAuthentications.Context.Users do
  alias Ticket_BE.Repo
  alias TicketAuthentications.Schemas.User
  import Ecto.Query, warn: false

  def create_user(email, pwd) do
    user_attr = %{
      email: email,
      pwd: pwd,
      enabled: false,
      is_deleted: false,
      created_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }

    # Repo.transaction(fn ->
    #   with {:ok, profile_data} <-
    #          %Profile{}
    #          |> Profile.changeset(profile_attr)
    #          |> Repo.insert(),
    #        {:ok, user_attr} <-
    #          %User{}
    #          |> User.changeset(Map.put(user_attr, :profile_id, profile_data.id))
    #          |> Repo.insert() do
    #     {:ok, "success"}
    #   else
    #     {:error, err} ->
    #       Repo.rollback(err)
    #   end
    # end)
  end
end
