defmodule CommitsComments.MixProject do
  use Mix.Project

  def project do
    [
      app: :commits_comments,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {CommitsComments.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.5"},
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.0"},
      {:plug, "~> 1.6"},
      {:bypass, "~> 0.9", only: [:dev, :test]}
    ]
  end
end
