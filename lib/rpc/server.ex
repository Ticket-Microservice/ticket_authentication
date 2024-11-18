defmodule TicketAuthentications.Greeter.Server do
  use GRPC.Server, service: TicketAuthentications.Greeter.Service
  alias TicketAuthentications.Greeter.SayHello, as: SayHello

  def say_hello(request, _stream) do
    SayHello.say_hello(request, _stream)
  end
end
