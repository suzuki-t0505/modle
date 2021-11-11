defmodule ModleTest do
  use ExUnit.Case
  doctest Modle

  test "greets the world" do
    assert Modle.hello() == :world
  end
end
