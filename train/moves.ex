defmodule Moves do
  def single({_, 0}, state) do
    state
  end
  def single({:one, ch}, {main, one, two}) do
    if ch > 0 do  #Move ch elements from main to one
      n = Enum.count(main)-ch
      {Listop.take(main, n), Listop.append(Listop.drop(main, n), one), two}
    else
      {Listop.append(main, Listop.take(one,-ch)), Listop.drop(one, -ch), two}
    end
  end
  def single({:two, ch}, {main, one, two}) do
    if ch > 0 do
      n = Enum.count(main)-ch
      {Listop.take(main, n), one, Listop.append(Listop.drop(main, n), two)}
    else
      {Listop.append(main, Listop.take(two,-ch)), one, Listop.drop(two, -ch)}
    end
  end

  def move([], state) do [state] end
  def move(singles, state) do

    if Enum.count(singles) > 1 do
      [h|t] = singles
      [state|move(t, single(h, state))]
    else
      [h] = singles
      [state | move([],single(h,state))] #Löste propblem att det blev | istället för , innan sista state mha []
    end

  end
end
