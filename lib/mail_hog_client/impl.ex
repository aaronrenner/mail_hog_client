defmodule MailHogClient.Impl do
  @moduledoc false

  alias MailHogClient.Message

  @callback get_messages :: {:ok, [Message.t()]}

  @callback delete_all_messages :: :ok
end
