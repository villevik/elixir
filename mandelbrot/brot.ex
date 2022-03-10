defmodule Brot do
  def mandelbrot(c, m) do
    z0 = Cmplx.new(0,0)
    i = 0
    test(i, z0, c, m)
  end
  def test(i, _, _ , i) do
    #When this function runs it's in the mandelbrot sequence if you have enough iterations
    #IO.write("i=m")
    0
  end
  def test(it, z, c, m) do
    abs = Cmplx.abs(z)
    sqr = Cmplx.sqr(z)
    {r,i} = c
    case abs <= 2 do
      true ->
        {zr, zi} = sqr
        newZ = {r + zr, i + zi}
        test(it+1, newZ, c, m)
      false ->
        #IO.write("Not in: #{abs}")
        it
    end
  end
end
