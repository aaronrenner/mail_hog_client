defmodule MailHogClient.TeslaImpl do
  @moduledoc false

  alias MailHogClient.Message
  alias Tesla.Client

  @behaviour MailHogClient.Impl

  @impl true
  @spec get_messages :: {:ok, [Message.t()]}
  def get_messages do
    client = build_client()

    {:ok, env} = Tesla.get(client, "/api/v1/messages")

    messages =
      for _raw_message <- env.body do
        %Message{}
      end

    {:ok, messages}
  end

  @impl true
  @spec delete_all_messages :: :ok
  def delete_all_messages do
    client = build_client()

    {:ok, _env} = Tesla.delete(client, "/api/v1/messages")

    :ok
  end

  @spec build_client :: Client.t()
  defp build_client do
    adapter = Tesla.Adapter.Hackney
    base_url = "http://localhost:8025"
    mailhog_json_response_content_type = "text/json"

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON,
       engine: Jason, decode_content_types: [mailhog_json_response_content_type]},
      Tesla.Middleware.Logger
    ]

    Tesla.client(middleware, adapter)
  end
end
