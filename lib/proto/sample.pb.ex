defmodule SampleApp.UserReply do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :id, 1, type: :int32
  field :first_name, 2, type: :string, json_name: "firstName"
  field :last_name, 3, type: :string, json_name: "lastName"
  field :age, 4, type: :int32
end

defmodule SampleApp.CreateRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :first_name, 1, type: :string, json_name: "firstName"
  field :last_name, 2, type: :string, json_name: "lastName"
  field :age, 3, type: :int32
end

defmodule SampleApp.GetRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.13.0"

  field :id, 1, type: :int32
end

defmodule SampleApp.User.Service do
  @moduledoc false

  use GRPC.Service, name: "sample_app.User", protoc_gen_elixir_version: "0.13.0"

  rpc :Create, SampleApp.CreateRequest, SampleApp.UserReply

  rpc :Get, SampleApp.GetRequest, SampleApp.UserReply
end

defmodule SampleApp.User.Stub do
  @moduledoc false

  use GRPC.Stub, service: SampleApp.User.Service
end