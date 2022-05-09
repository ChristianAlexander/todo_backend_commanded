# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :todo_backend,
  ecto_repos: [TodoBackend.Repo]

# Configures the endpoint
config :todo_backend, TodoBackendWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TodoBackendWeb.ErrorView, accepts: ~w(json), layout: false]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :todo_backend, TodoBackend.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: TodoBackend.EventStore
  ],
  pubsub: :local,
  registry: :local

config :todo_backend, event_stores: [TodoBackend.EventStore]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
