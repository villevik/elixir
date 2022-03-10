defmodule Mandel do
  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end
    widthIn = width
    rows(width, widthIn, height, trans, depth, [], [])
  end

  def rows(_, _, 0, _, _, colors, _) do
    IO.write("Complete!")
    colors
  end
  #New row
  def rows(0, widthIn, height, trans, depth, colors, color) do
    #IO.write("#{height} ")
    width = widthIn
    rows(width, widthIn, height - 1, trans, depth, [color|colors], [])
  end
  def rows(width, widthIn, height, trans, depth, colors, color) do
    #IO.write("#{width} ")
    c = trans.(width, height)
    brot = Brot.mandelbrot(c, depth)
    col = Color.convert(brot, depth)
    rows(width - 1, widthIn, height, trans, depth, colors, [col|color])
  end
end
