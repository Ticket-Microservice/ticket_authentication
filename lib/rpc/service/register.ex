defmodule TicketAuthentications.Register do
  use GRPC.Server, service: TicketAuthentications.Register.Service
  alias GRPC.Status
  alias Authentication.Schemas.Users, as: Users
  alias TicketAuthentications.Context.Users, as: ContextUser
  alias Authentication.ErrorHandler

  require Logger

  def register(request, _stream) do
    # raise GRPC.RPCError.exception(GRPC.Status.invalid_argument(), "Hallo")
    data = %{email: request.email, pwd: request.pwd}

    changeset =
      Users.changeset(%Users{}, data)

    if !changeset.valid? do
      raise GRPC.RPCError.exception(
              GRPC.Status.invalid_argument(),
              ErrorHandler.changeset_error_handler_msg(changeset, [])
            )
    end

    resp = ContextUser.create_user(request.email, request.pwd)

    case resp do
      {:ok, _} ->
        TicketAuthentications.BlankResponse.new()

      {:error, changeset} ->
        raise GRPC.RPCError.exception(
                GRPC.Status.invalid_argument(),
                ErrorHandler.changeset_error_handler_msg(changeset, [])
              )
    end
  end

  def login(request, _stream) do
    # raise GRPC.RPCError.exception(GRPC.Status.invalid_argument(), "Hallo")
    try do
      data = %{email: request.email, pwd: request.pwd}

      changeset =
        Users.changeset(%Users{}, data)

      if !changeset.valid? do
        raise GRPC.RPCError.exception(
                GRPC.Status.invalid_argument(),
                ErrorHandler.changeset_error_handler_msg(changeset, [])
              )
      end

      case Authentication.Guardian.authenticate(
             request.email,
             request.pwd
           ) do
        {:ok, token, _payload} ->
          %TicketAuthentications.LoginResponse{
            jwt: token
          }

        {:error, msg} ->
          raise GRPC.RPCError.exception(
                  GRPC.Status.not_found(),
                  msg
                )
      end
    rescue
      e ->
        Logger.error(e)

        raise GRPC.RPCError.exception(
                GRPC.Status.unknown(),
                e
              )
    end
  end
end
