defmodule Place.Sup do
  def run(pid_map) do
    listen(pid_map)
    run(pid_map)
  end

  def listen(pid_map) do
    receive do
      {:update, _, x, y, value} ->
        index = rem(x * 1000 + y, 100)
        position = div(x, 100) * 10 + div(y, 100)
        send(pid_map[index], {:update, self(), position, value})

      {:state, high_pid, x, y} ->
        index = rem(x * 1000 + y, 100)
        position = div(x, 100) * 10 + div(y, 100)
        send(pid_map[index], {:state, high_pid, position})

        pid_map
    end
  end
end
