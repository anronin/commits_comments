defmodule CommitsComments.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  forward("/commits_comments", to: CommitsComments.Plugs.Comments)

  match _ do
    send_resp(conn, 200, "Hi!")
  end
end
