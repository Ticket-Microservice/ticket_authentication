defmodule TicketAuthentications.RPC.Register do
  use GRPC.Server, service: TicketAuthentications.Register.Service
  alias GRPC.Status
  alias Authentication.Schemas.Users, as: Users
  alias TicketAuthentications.Context.Users, as: ContextUser
  alias TicketAuthentications.Context.Sessions
  alias Authentication.ErrorHandler

  require Logger

  @rabbitmq_url Application.get_env(:authentication, TicketAuthentications.RPC.Register)[:rabbitmq_url]
  @rabbitmq_port Application.get_env(:authentication, TicketAuthentications.RPC.Register)[:rabbitmq_port]

  def register(request, _stream) do
    try do
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
        send_welcome_email(request.email)
        TicketAuthentications.BlankResponse.new()

      {:error, changeset} ->
        raise GRPC.RPCError.exception(
                GRPC.Status.invalid_argument(),
                ErrorHandler.changeset_error_handler_msg(changeset, [])
              )
    end
    rescue e ->
      Logger.error(e)
      raise GRPC.RPCError.exception(
                GRPC.Status.internal(),
                "Something went wrong with register"
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

  def check_token(request, _stream) do
    IO.inspect(request)

    if !request.user_id ||
         request.user_id == "" ||
         !request.jwt ||
         request.jwt == "" do
      msg = "user_id or jwt is not specified"

      raise GRPC.RPCError.exception(
              GRPC.Status.invalid_argument(),
              msg
            )
    end

    %TicketAuthentications.CheckTokenResponse{
      isValid: Sessions.check_token(String.to_integer(request.user_id), request.jwt)
    }
  end

  defp send_welcome_email(email) do
    options = [host: @rabbitmq_url, port: @rabbitmq_port]

    {:ok, connection} = AMQP.Connection.open(options)
    {:ok, channel} = AMQP.Channel.open(connection)

    msg = %{
      cmd: "welcome",
      params: %{
        send_to: email
      }
    }

    msg_json = Jason.encode!(msg)

    data =
      case Jason.decode(msg_json) do
        {:ok, data} -> data["params"]
        {:error, reason} -> IO.inspect(reason, label: "data")
      end
      |> IO.inspect(label: "data")

    AMQP.Basic.publish(channel, "email_dlx", "send_email", msg_json)

    AMQP.Connection.close(connection)
  end
end
