defmodule TicketAuthentications.RPC.HealthCheck do
  use GRPC.Server, service: HealthCheck.HealthCheck.Service

  def check_health(request, _stream) do
    %HealthCheck.BlankResponse{}
  end
end
