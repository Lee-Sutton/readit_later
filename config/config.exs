# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :readit_later,
  ecto_repos: [ReaditLater.Repo]

# Configures the endpoint
config :readit_later, ReaditLaterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JT2IhL1oH3rgBTg2m0NTkH1XvQNgiid3ShjtiWKIQh9k8tp++nHRqNrByyjcPpk5",
  render_errors: [view: ReaditLaterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ReaditLater.PubSub,
  live_view: [signing_salt: "QEEu94Sb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
