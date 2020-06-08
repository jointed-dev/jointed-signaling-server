# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :jointed_signaling_server, JointedSignalingServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o3FyhB50U5o8lMjGtNFv6m+bicaoGOy2SacrgPUl3IzE8k2hz4qBOFkNS8lG4oXu",
  render_errors: [view: JointedSignalingServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: JointedSignalingServer.PubSub,
  live_view: [signing_salt: "viIkJzmS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
