defmodule Counter.Sup do
  def run(pid_map) do
    listen(pid_map)
    run(pid_map)
  end

  def listen(pid_map) do
    receive do
      {:update, _, x, y, value} ->
        index = div(x, 100) * 10 + div(y, 100)
        position = rem(x * y, 10000)
        send(pid_map[index], {:update, self(), position, value})

      {:state, high_pid, x, y} ->
        index = div(x, 100) * 10 + div(y, 100)
        positon = rem(x * y, 10000)
        send(pid_map[index], {:state, high_pid, positon})

        pid_map
    end
  end
end
