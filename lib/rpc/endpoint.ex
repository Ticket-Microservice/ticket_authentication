defmodule TicketAuthentications.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger
  run TicketAuthentications.Greeter.Server
  run TicketAuthentications.RPC.Register
  run TicketAuthentications.Reflection.Server
  run TicketAuthentications.RPC.HealthCheck
end
