defmodule CounterTest do
  use ExUnit.Case
  doctest Counter

  test "greets the world" do
    assert Counter.Core.inc(1) == 2
  end

  test "use counter thru API" do
    pid = Counter.start(0)
    assert Counter.state(pid) == 0

    Counter.tick(pid)
    Counter.tick(pid)

    assert Counter.state(pid) == 2
  end
end
