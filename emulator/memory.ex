defmodule Memory do
  def new() do
    new([])
  end
  def new(segments) do

  end
  def read(mem, i) do
    [h | t] = mem
    case h do
      {i, val} -> val
      {_} -> read(t, i)
    end
  end
  def write(mem, i, val) do
    mem = [{i, val} | mem]
  end
end
