# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blackspider,
  ecto_repos: [Blackspider.Repo]

# Configures the endpoint
config :blackspider, BlackspiderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xU98a0uqFjIa5oz+UTV5G6UGvUNsHA0259qyjD+D0uu3RrBvTVhH4uK8tPeBr5BS",
  render_errors: [view: BlackspiderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blackspider.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
