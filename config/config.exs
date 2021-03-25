# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wait_list,
  ecto_repos: [WaitList.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :wait_list, WaitListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eCk7ZDeQzKhBZdmFVrZN6a7mT+BeqlzHaUsBH86JzCMxOkFwaHWLs7NcgMQbTNE5",
  render_errors: [view: WaitListWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WaitList.PubSub,
  live_view: [signing_salt: "j+/fzGNr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
