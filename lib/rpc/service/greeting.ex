defmodule TicketAuthentications.Greeter.Server do
  use GRPC.Server, service: TicketAuthentications.Greeter.Service

  def say_hello(request, _stream) do
    # raise GRPC.RPCError.exception(GRPC.Status.invalid_argument(), "Hallo")
    TicketAuthentications.HelloReply.new(message: "asqweq #{request.name}")
  end
end
