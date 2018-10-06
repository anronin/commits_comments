defmodule CommitsComments.Plugs.CommentsTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import ExUnit.CaptureLog

  alias CommitsComments.Plugs.Comments
  alias Plug.Conn

  setup do
    path = "/commits_comments"
    user_login = "anronin"
    commit_id = "a10867b14bb761a232cd80139fbd4c0d33264240"
    comment = "This is a really good change! :+1:"

    comment_created =
      File.read!("test/fixtures/comment_created.json.eex")
      |> EEx.eval_string(comment: comment, user_login: user_login, commit_id: commit_id)

    {:ok, path: path, comment_created: comment_created, comment: comment, user_login: user_login, commit_id: commit_id}
  end

  test "valid webhook with comment", ctx do
    conn = build_conn(:post, ctx.path, ctx.comment_created)

    [_, new_comment_created, repository, commit_id, user, comment, _] =
      capture_log_lines(fn ->
        Comments.call(conn)
      end)

    assert new_comment_created =~ "New comment created ===="
    assert repository == "Repository: Hello-World"
    assert commit_id == "Commit_id: #{ctx.commit_id}"
    assert user == "User: #{ctx.user_login}"
    assert comment == "Comment: #{ctx.comment}"
  end

  test "valid webhook without comment", ctx do
    conn = build_conn(:post, ctx.path, "{}")

    log =
      capture_log_lines(fn ->
        Comments.call(conn)
      end)

    conn = Comments.call(conn)

    assert log == []
    assert conn.resp_body == ""
    assert conn.status == 200
  end

  test "conn isn't halted on random url" do
    conn = build_conn(:get, "/fake") |> Comments.call()
    assert conn.halted == false
  end

  def build_conn(method, path, params_or_body \\ nil) do
    Plug.Adapters.Test.Conn.conn(%Conn{}, method, path, params_or_body)
  end

  defp capture_log_lines(fun) do
    fun
    |> capture_log()
    |> String.split("\n", trim: true)
  end
end
