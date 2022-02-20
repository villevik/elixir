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
  def take(xs, n) do
    [h|t] = xs
    if(n > 0) do
      [h|take(t,n-1)]
    else
      []
    end
  end
  def drop([],n) do
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
  def member([], y) do
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
