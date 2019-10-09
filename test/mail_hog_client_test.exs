defmodule MailHogClientTest do
  use ExUnit.Case
  doctest MailHogClient

  test "greets the world" do
    assert MailHogClient.hello() == :world
  end
end
