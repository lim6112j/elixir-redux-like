defmodule ReduxLikeTest do
  use ExUnit.Case
  doctest ReduxLike

  test "greets the world" do
    assert ReduxLike.hello() == :world
  end
end
