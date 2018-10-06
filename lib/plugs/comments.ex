defmodule CommitsComments.Plugs.Comments do
  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, opts \\ [])

  def call(%{method: "POST"} = conn, _opts) do
    {:ok, body, conn} = read_body(conn)

    response = Jason.decode!(body)

    if response["comment"] do
      Logger.info fn ->
        """
        New comment created ====
        Repository: #{response["repository"]["name"]}
        Commit_id: #{response["comment"]["commit_id"]}
        User: #{response["comment"]["user"]["login"]}
        Comment: #{response["comment"]["body"]}
        """
      end
    end

    send_resp(conn, 200, "")
  end

  def call(conn, _opts), do: conn
end
