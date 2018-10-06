# CommitsComments

To start using the application:

  * Install dependencies with `mix deps.get`
  * Generate access token on [`GitHub`](https://github.com/settings/tokens/new) and save it
  * Export access token as shell variable `export GITHUB_ACCESS_TOKEN="saved access token"`
  * Set webhook url in `config.exs`
  * Set webhook for repository with `CommitsComments.set_webhook("owner", "repo", ["list", "of", "events"])`
