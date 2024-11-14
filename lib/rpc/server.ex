defmodule TicketAuthentications.Greeter.Server do
  use GRPC.Server, service: TicketAuthentications.Greeter.Service

  @spec say_hello(TicketAuthentications.HelloRequest.t, GRPC.Server.Stream.t) :: TicketAuthentications.HelloReply.t
  def say_hello(request, _stream) do
    TicketAuthentications.HelloReply.new(message: "asqweq #{request.name}")
  end
end
