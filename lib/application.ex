defmodule CommitsComments.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Adapters.Cowboy2,
       scheme: :http, plug: CommitsComments.Router, options: Application.get_env(:commits_comments, :adapter_options)}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CommitsComments.Supervisor)
  end
end
