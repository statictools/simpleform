# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :simpleform, Simpleform.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "TVW+4aglKMVgn7ub3U2pw9UJTf0T7nC/m4NaP7/S7VJeagFHeZTbVUiXb53hZr+o",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Simpleform.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  #allowed_algos: ["HS512"], # optional
  #verify_module: Guardian.JWT,  # optional
  issuer: "Simpleform",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "AK0O6yVJ/Pv8RUgjratOQW1PjnrvdlDW/a3yHIzNGTk=",
  serializer: Simpleform.GuardianSerializer
