defmodule Test do
  def onePlus(x) do
    x + 1
  end
  def isEven(x) do
    if rem(x,2) == 0 do
      true
    else
      false
    end
  end
end
