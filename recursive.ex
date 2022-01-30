defmodule Recursive do
    def multiply(m,n) do
      if m==0 do
        0
      else
        if(m<0) do
          0 - (n - multiply(m+1,n)) # 3 - 3 - 0
        else
          n + multiply(m-1,n) # multiply(2,3)-> 3 + 3 + 0
        end
      end
    end
    def sum(l) do
      if(l == []) do
        0
      else
        [head | tail] = l
        head + sum(tail)
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
