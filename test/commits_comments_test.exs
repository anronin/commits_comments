defmodule CommitsCommentsTest do
  use ExUnit.Case
  doctest CommitsComments

  setup do
    bypass = Bypass.open()
    base_url = "http://localhost:#{bypass.port}/"

    :ok = Application.put_env(:commits_comments, :api_base_url, base_url)

    on_exit fn ->
      Application.delete_env(:commits_comments, :api_base_url)
    end

    {:ok, bypass: bypass}
  end

  test "webhook created", ctx do
    Bypass.expect(ctx.bypass, fn conn -> Plug.Conn.resp(conn, 201, "") end)

    assert CommitsComments.set_webhook("anronin", "commits_comments", ["commit_comment"]) == {:ok, :webhook_created}
  end

  test "invalid request", ctx do
    Bypass.expect(ctx.bypass, fn conn -> Plug.Conn.resp(conn, 422, "") end)

    assert CommitsComments.set_webhook("", "", []) == {:error, :invalid_request}
  end
end
