defmodule TicketAuthentications.HelloRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :name, 1, type: :string
end

defmodule TicketAuthentications.HelloReply do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :message, 1, type: :string
end

defmodule TicketAuthentications.Greeter.Service do
  @moduledoc false

  use GRPC.Service, name: "ticket_authentications.Greeter", protoc_gen_elixir_version: "0.13.0"

  rpc :SayHello, TicketAuthentications.HelloRequest, TicketAuthentications.HelloReply
end

defmodule TicketAuthentications.Greeter.Stub do
  @moduledoc false

  use GRPC.Stub, service: TicketAuthentications.Greeter.Service
end