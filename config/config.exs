# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  namespace: TokenxApi,
  ecto_repos: [TokenxApi.Repo]

# Configures the endpoint
config :api, TokenxApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "He8Ny2Aq/24iIM4Tu+sWZfxBqligaAzsARSDr7aESHOGwYDim3r4Ks3EYyeYy82E",
  render_errors: [view: TokenxApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TokenxApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
