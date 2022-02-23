defmodule Listop do
  def position(xs, y) do
    position(xs,y,1)
  end
  def position(xs, y, i) do
    [h|t] = xs
    if(h==y) do
      i
    else
      position(t,y,i+1)
    end
  end
  def take(_, 0) do [] end
  def take(xs, n) do
    if(Enum.count(xs) < 2 && n > 0) do
      xs
    else
      [h|t] = xs
      if(n > 0) do
        [h|take(t,n-1)]
      else
        []
      end
    end

  end
  def drop([],_) do
    []
  end
  def drop(xs, n) do
    [h|t] = xs
    if(n > 0) do
      drop(t,n-1)
    else
      [h | drop(t,n)]
    end
  end
  def append(xs, ys) do
    xs ++ ys
  end
  def member([], _) do
    false
  end
  def member(xs,y) do
    [h|t] = xs
    if(h == y) do
      true
    else
      member(t, y)
    end
  end
end
