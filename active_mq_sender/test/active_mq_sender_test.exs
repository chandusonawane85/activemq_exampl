defmodule ActiveMqSenderTest do
  use ExUnit.Case
  doctest ActiveMqSender

  test "greets the world" do
    assert ActiveMqSender.hello() == :world
  end
end
