defmodule Register do
  def new() do
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} #32 registers
  end
  def read(reg, i) do
    elem(reg, i)
  end
  def write(reg, i, val) do
    put_elem(reg, i, val)
  end
end
