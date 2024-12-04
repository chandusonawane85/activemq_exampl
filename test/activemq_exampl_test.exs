defmodule ActivemqExamplTest do
  use ExUnit.Case
  doctest ActivemqExampl

  test "greets the world" do
    assert ActivemqExampl.hello() == :world
  end
end
