defmodule CommitsComments do
  @moduledoc false

  @spec set_webhook(String.t(), String.t(), [String.t()]) :: term
  def set_webhook(owner, repo, events) do
    payload = prepare_webhook_params(events)
    access_token = Application.get_env(:commits_comments, :access_token)

    api_url =
      Application.get_env(:commits_comments, :api_base_url) <>
        "/repos/#{owner}/#{repo}/hooks?access_token=#{access_token}"

    case HTTPoison.post(api_url, Jason.encode!(payload)) do
      {:ok, %HTTPoison.Response{status_code: 201}} -> {:ok, :webhook_created}
      _ -> {:error, :invalid_request}
    end
  end

  defp prepare_webhook_params(events) do
    %{
      name: "web",
      active: true,
      events: events,
      config: %{
        url: Application.get_env(:commits_comments, :webhook_url),
        content_type: "json"
      }
    }
  end
end
