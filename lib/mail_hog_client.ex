defmodule MailHogClient do
  @moduledoc """
  API client for MailHog
  """

  @behaviour MailHogClient.Impl

  @doc """
  Gets the list of messages from the server
  """
  @impl true
  @spec get_messages :: {:ok, [Message.t()]}
  def get_messages do
    impl().get_messages()
  end

  @doc """
  Deletes all messages in MailHog
  """
  @impl true
  @spec delete_all_messages :: :ok
  def delete_all_messages do
    impl().delete_all_messages()
  end

  defp impl do
    Application.get_env(:mail_hog_client, :impl, MailHogClient.TeslaImpl)
  end
end
