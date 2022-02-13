defmodule Out do
  def put(out, s) do
    [s | out]
  end
  def close(out) do
    Enum.reverse(out)
  end
end
