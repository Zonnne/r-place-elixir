defmodule Place.Server do
  def init do
    kv = :ets.new(:kvmap, [:set, :protected, read_concurrency: true])
    for n <- 0..9999, do: :ets.insert(kv, {n, 1})
    run(kv)
  end

  def run(state) do
    new_state = listen(state)
    run(new_state)
  end

  def listen(state) do
    receive do
      {:update, _pid, position, value} ->
        Place.Core.set(state, position, value)

      {:state, pid, position} ->
        [{_, value}] = :ets.lookup(state, position)
        send(pid, {:count, value})

        state
    end
  end
end
