defmodule Counter.Core do
  def set(state, x, value) do
    %{state | x => value}
  end
end
