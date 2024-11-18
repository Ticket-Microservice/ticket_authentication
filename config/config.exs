# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :authentication,
  ecto_repos: [Authentication.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :authentication, AuthenticationWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: AuthenticationWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Authentication.PubSub,
  live_view: [signing_salt: "NVx2/StS"]

config :authentication, Ticket_BE.Guardian,
  issuer: "ticket_BE",
  secret_key: System.get_env("SECRET_KEY"),
  # serializer: Ticket_BE.GuardianSerializer,
  allowed_algos: ["HS512"] # optional
  # verify_module: Guardian.JWT,  # optional
  # issuer: "Ticket_BE", # optional
  # # ttl: { 1, :days },
  # allowed_drift: 2000,
  # verify_issuer: true # optional

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :authentication, Authentication.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
