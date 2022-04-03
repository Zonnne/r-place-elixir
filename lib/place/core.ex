defmodule Place.Core do
  def set(state, x, value) do
    :ets.insert(state, {x, value})
    state
  end
end
