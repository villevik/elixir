defmodule Prime do
  def first(n) do
    list = Enum.to_list(2..n)

    #IO.write("Ye")
    primes1 = iterate(list,0)
    #IO.write("\n#{Enum.count(primes1)}")
    primes2 = outer(list, primes1, 0, [])
    #IO.write("#{Enum.count(primes2)}")
    primes3 = reverse_prime(outer(list, primes1, 0, []))

    #t1 = elem(:timer.tc(fn -> iterate(list,0) end),0)
    #t2 = elem(:timer.tc(fn -> outer(list, primes1, 0, []) end),0)
    #t3 = elem(:timer.tc(fn -> reverse_prime(outer(list, primes1, 0, [])) end),0)
    #IO.write("\n#{n}\t\t#{t1}\t\t#{t2}\t\t#{t3}")
  end
  ##Första uppgiften
  def iterate([], _) do [] end
  def iterate(l, i) do
    if i >= Enum.count(l) do
      l
    else
    #[h|t] = l #ej använd?
    list =  filter(l, fn(e) ->
      case rem(e, nth(i, l)) do
        0 -> false
        _ -> true
      end
    end)
    list = iterate(list, i+1)
    end
  end

  def filter([], _) do [] end
  def filter(l, f) do
    [h|t] = l
    #IO.write("#{h}\n")
   case f.(h) do
      true -> [h | filter(t, f) ]
      false -> filter(t, f)
   end
  end

  ##Andra uppgiften
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
  def put(out, s) do
    [s | out]
  end

  #primes2 = outer(list, primes1, 0, [])
  def outer(list, primes, i, newlist) do
    if i < Enum.count(list) do
      IO.write("\n#{Enum.at(list,i)}")
      newlist = [inner(Enum.at(list,i), primes, 0) | newlist]
      newlist = outer(list, primes, i+1, newlist)
    else
      newlist
    end

  end


  def inner(t, primes, j) do
    #[h|l] = primes
    if rem(t,Enum.at(primes,j)) != 0 do
      t
    else
      inner(t, primes, j+1)
    end
  end




  def reverse_prime(list)do
    Enum.reverse(list)
  end

end


#######
#######list = filter(list, fn(e) -> case rem(e, 2) do
#######  0 -> false
#######  _ -> true
#######end
#######end)

#######list = filter(list, fn(e) -> case rem(e, 3) do
 ####### 0 -> false
#######  _ -> true
#######end
#######end)
  def prime_check(_,[],newPrimes) do
    newPrimes
  end
  def prime_check(list, primes, newPrimes) do

    [head|tail] = primes
    newPrimes = prime_filter2(list,
      fn(e) ->
        IO.write("#{e}\t#{head}\n")
        if(head == e) do  #delar sig själv
          false
        else
          case rem(e, head) do
            0 -> true #if delbar
            _ -> false  #inte delbar
          end
        end
      end, newPrimes)
    newPrimes = prime_check(list, tail, newPrimes)
  end

  def prime_filter2([], _, new) do [] end
  def prime_filter2(l, f, new) do
    [h|t] = l
    IO.write("#{h}\n")
    case f.(h) do
        true -> new = put(new, h) #if delbar med primtalet -> lägg till i lista
        false -> prime_filter2(t, f, new)       #om inte kolla nästa
    end
  end

  ###
  def prime_filter([], _, new) do new end
  def prime_filter(l, f, i) do
    IO.write("\n#{Enum.count(l)}\n")
    if Enum.count(l) <= i do
      [h|t] = l
      #IO.write("#{h}\n")
      case f.(h) do
          true -> [h | prime_filter(t, f, i)]
          false -> prime_filter(t, f, i)
      end
    end
  end

  def iterate2([], _, _) do [] end
  def iterate2(l, i, primes) do
    if i >= Enum.count(l) do
      l
    else
    [h|t] = l #ej använd?
    IO.write("\n#{Enum.at(primes, i)}\n")
    IO.write("#{Enum.at(primes, 0)}\n")
    IO.write("#{nth(0, primes)}\n")
    IO.write("#{nth(i, primes)}\n")
    list =  prime_filter(l,
      fn(e) ->
        case rem(e, nth(i, primes)) do
          0 -> false
          _ -> true
        end
      end,
      Enum.count(primes)
    )
    list = iterate2(list, i+1, primes)
    end
  end

  def prime_list(l, n) do
    [h|t] = l
    case rem(h,n) do
      0 -> true
      _ -> false
    end
  end
