defmodule TicketAuthentications.Register do
  use GRPC.Server, service: TicketAuthentications.Register.Service
  alias GRPC.Status
  alias Authentication.Schemas.Users
  alias Ticket_BE.ErrorHandler

  def register(request, _stream) do
    # raise GRPC.RPCError.exception(GRPC.Status.invalid_argument(), "Hallo")
    changeset =
      Users.changeset(%Users{}, %{email: request.email, pwd: request.pwd})

    if !changeset.valid? do
      raise GRPC.RPCError.exception(
              GRPC.Status.invalid_argument(),
              ErrorHandler.changeset_error_handler_msg(changeset, [])
            )
    end

    TicketAuthentications.BlankResponse.new()
  end
end
