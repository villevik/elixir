defmodule Shunt do
  def find([],_) do
    []
  end
  #Först ska vi ta reda på vilket element vi ska lägga först på main
  #Vi gör moves för att lägga detta elementet på sin plats
  #Vi lägger till dessa moves i början på en lista
  #Vi kallar på funktionen igen med svansen av nya xs och ys
  def find(xs, ys) do
    if(Enum.count(xs) > 1 && Enum.count(ys) > 1) do
      [hy|ty] = ys
      {hs,ts} = split(xs, hy)

      mvl = [{:one, Enum.count(ts)+1}, {:two, Enum.count(hs)}, {:one, -Enum.count(ts)-1}, {:two, -Enum.count(hs)}]
      stateAfter = Moves.move(mvl, {xs,[],[]})
      {main, [],[]} = Enum.at(stateAfter, Enum.count(stateAfter)-1)

      [hx|tx] = main
      [mvl | find(tx,ty)]
    else
      []
    end
  end
  #Om positionen av head-elementet i xs och ys skall vi inte lägga till några moves
  #Vi ska kalla på few() med tx och ty fortfarande
  def few([],_) do [] end
  def few(xs, ys) do

    if(Enum.count(xs) > 1 && Enum.count(ys) > 1) do
      [hy|ty] = ys
      [hx|tx] = xs
      if(Listop.position(ys,hy) == Listop.position(xs,hy)) do
        #IO.write("hey")
        few(tx,ty)
      else
        #IO.write("Yo")
        {hs,ts} = split(xs, hy)
        mvl = [{:one, Enum.count(ts)+1}, {:two, Enum.count(hs)}, {:one, -Enum.count(ts)-1}, {:two, -Enum.count(hs)}]
        stateAfter = Moves.move(mvl, {xs,[],[]})
        {main, [],[]} = Enum.at(stateAfter, Enum.count(stateAfter)-1)

        [hx|tx] = main
        [mvl | few(tx,ty)]
      end
    else
      []
    end
  end

  def split(list, d) do
    p = Listop.position(list, d)
    hs = Listop.take(list, p-1)
    ts = Listop.drop(list, p)
    {hs,ts}
  end

  def compress(ms) do
    ns = rules(ms)
    if ns == ms do
      ms
    else
      compress(ns)
    end
  end
  def rules([]) do [] end
  def rules(ms) do
    if Enum.count(ms) > 2 do
      [{r1,v1}|t] = ms
      if v1 == 0 do
        rules(t)
      else
        [{r2,v2}|t2] = t
        if r1 == r2 do
          [{r1,v1+v2}|rules(t2)]#t elr t2?
        else
          [{r1,v1}|rules(t)]
        end
      end
    else
      if Enum.count(ms) > 1 do
        [{r1,v1}|t] = ms
        if v1 == 0 do
          rules(t)
        else
          [{r2,v2}] = t
          if r1 == r2 do
            [{r1,v1+v2}]
          else
            rules(t)
          end
        end
      else
        [{r1,v1}] = ms
        if v1 == 0 do
          []
        else
          ms
        end
      end
    end

  end
end
