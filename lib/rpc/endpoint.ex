defmodule TicketAuthentications.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger
  run TicketAuthentications.Greeter.Server
end
