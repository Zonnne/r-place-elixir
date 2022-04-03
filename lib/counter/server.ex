defmodule Counter.Server do
  def run(state) do
    new_state = listen(state)
    run(new_state)
  end

  def listen(state) do
    receive do
      {:update, _pid, position, value} ->
        Counter.Core.set(state, position, value)

      {:state, pid, position} ->
        send(pid, {:count, state[position]})

        state
    end
  end
end
