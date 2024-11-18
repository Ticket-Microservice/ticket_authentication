defmodule TicketAuthentications.Greeter.SayHello do
  alias GRPC.Status

  @spec say_hello(TicketAuthentications.HelloRequest.t, GRPC.Server.Stream.t) :: TicketAuthentications.HelloReply.t
  def say_hello(request, _stream) do
    # raise GRPC.RPCError.exception(GRPC.Status.invalid_argument(), "Hallo")
    TicketAuthentications.HelloReply.new(message: "asqweq #{request.name}")
  end
end
