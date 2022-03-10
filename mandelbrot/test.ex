defmodule Test do
  def demo() do
    small(-0.6, 0.65, -0.4)
  end
  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 100
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small5.ppm", image)
  end

end
