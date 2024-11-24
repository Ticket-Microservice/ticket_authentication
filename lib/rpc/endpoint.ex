defmodule TicketAuthentications.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger
  run TicketAuthentications.Greeter.Server
  run TicketAuthentications.Register
  run TicketAuthentications.Reflection.Server
end
