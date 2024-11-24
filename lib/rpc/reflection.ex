defmodule TicketAuthentications.Reflection.Server do
  use GrpcReflection.Server,
    version: :v1alpha,
    services: [TicketAuthentications.Greeter.Service, TicketAuthentications.Register.Service]
end
