use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jointed_signaling_server, JointedSignalingServerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :jointed_signaling_server, :children, [
  JointedSignalingServerWeb.Telemetry,
  {Phoenix.PubSub, name: JointedSignalingServer.PubSub},
  JointedSignalingServerWeb.Endpoint
]

# Print only warnings and errors during test
config :logger, level: :warn
