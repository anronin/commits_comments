use Mix.Config

config :bypass, adapter: Plug.Adapters.Cowboy2

config :commits_comments, :adapter_options, port: 4001
