defmodule PlaceTest do
  use ExUnit.Case
  doctest Place

  test "use counter thru API" do
    pid = Place.start()

    for x <- 0..999, do: Place.update(pid, x, x, rem(x + x, 9))
    for x <- 0..999, do: assert(Place.state(pid, x, x) == rem(x + x, 9))
  end
end
