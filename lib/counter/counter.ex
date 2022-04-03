defmodule Counter do
  @moduledoc """
  Documentation for `Counter`.
  """

  @doc """
  Hello world.

  """
  def start() do
    pid_map = for n <- 1..100, into: %{}, do: {n, subserver()}
    spawn(fn -> Counter.Sup.run(pid_map) end)
  end

  defp subserver do
    map = for n <- 1..10000, into: %{}, do: {n, 1}
    spawn(fn -> Counter.Server.run(map) end)
  end

  def update(sup_pid, x, y, value)
      when is_integer(x) and x in 1..1000
      when is_integer(y) and y in 1..1000
      when is_integer(value) and value in 1..9 do
    send(sup_pid, {:update, self(), x, y, value})
  end

  def state(pid, x, y)
      when is_integer(x) and x in 1..1000
      when is_integer(y) and y in 1..1000 do
    send(pid, {:state, self(), x, y})

    receive do
      {:count, value} -> value
    end
  end
end
