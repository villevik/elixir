defmodule Primes do
  def test(n) do
    list = Enum.to_list(2..n)
    primes = first(list, 0) #2,3,5,7
    #IO.write("#{Enum.count(primes)}")
  end
  def first([]) do [] end
  def first(l, i) do
    if i < Enum.count(l) do #i >= 0 do
      list = [nth(i,l) | filter(l, nth(i, l))]
      list = first(list, i+1)
    else
      Enum.reverse(l)
    end
  end
  def second(l, i) do
    if i < Enum.count(l) do
      list = [nth(i,l) | filter(l, nth(i, l))]
      list = first(list, i+1)
    else
      Enum.reverse(l)
    end
  end
  def filter([], _) do [] end
  def filter(l, e) do
    if 1 < Enum.count(l) do
      [h|t] = l
      #if h==e do
      #  [h | filter(t,e)]
      #else
        case rem(h,e) do
          0 -> filter(t,e)
          _ -> [h | filter(t, e) ]
        end
      #end

    else
      [h] = l
      case rem(h,e) do
        0 -> []
        _ -> [h]
      end
    end
  end

  def nth(n,l) do
    if(l == []) do
      0
    else
      [head | tail] = l
      if(n>0) do
        nth(n-1,tail)
      else
        head
      end
    end
  end
end
