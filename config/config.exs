use Mix.Config

config :commits_comments,
  api_base_url: "https://api.github.com",
  webhook: "http://example.com/webhook",
  access_token: System.get_env("GITHUB_ACCESS_TOKEN")

import_config "#{Mix.env}.exs"
