defmodule MailHogClient.IntegrationTest do
  use ExUnit.Case, async: false

  alias Mailman.Context
  alias Mailman.Email
  alias Mailman.SmtpConfig

  setup [:reset_mailhog]

  test "retrieving a sent message" do
    {:ok, []} = MailHogClient.get_messages()

    send_email()

    {:ok, messages} = MailHogClient.get_messages()

    assert length(messages) == 1
  end

  defp send_email() do
    email = %Email{
      from: "sender@example.com",
      to: ["recipient@example.com"],
      text: "A sample message"
    }

    context = %Context{
      config: %SmtpConfig{
        relay: "localhost",
        port: 1025
      }
    }

    {:ok, _} = Mailman.deliver(email, context)
  end

  defp reset_mailhog(_) do
    :ok = MailHogClient.delete_all_messages()

    :ok
  end
end
