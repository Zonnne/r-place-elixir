defmodule Place do
  @moduledoc """
  Documentation for `Place`.
  """

  @doc """
  Hello world.

  """
  def start() do
    pid_map = for n <- 0..99, into: %{}, do: {n, subserver()}
    spawn(fn -> Place.Sup.run(pid_map) end)
  end

  defp subserver do
    spawn(fn -> Place.Server.init() end)
  end

  def update(sup_pid, x, y, value)
      when is_integer(x) and x in 0..999
      when is_integer(y) and y in 0..999
      when is_integer(value) and value in 0..9 do
    send(sup_pid, {:update, self(), x, y, value})
  end

  def state(pid, x, y)
      when is_integer(x) and x in 0..999
      when is_integer(y) and y in 0..999 do
    send(pid, {:state, self(), x, y})

    receive do
      {:count, value} -> value
    end
  end
end
