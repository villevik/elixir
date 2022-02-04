defmodule Bench do

  def bench() do bench(100) end

  def bench(l) do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> loop(l, fn -> f.(seq) end) end),0)
    end

    bench = fn (i) ->

      list = fn (seq) ->
        List.foldr(seq, list_new(), fn (e, acc) -> list_insert(e, acc) end)
      end

      tree = fn (seq) ->
        List.foldr(seq, tree_new(), fn (e, acc) -> tree_insert(e, e, acc) end)
      end

      tl = time.(i, list)
      tt = time.(i, tree)

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree (loop: #{l}) \n")
    Enum.map(ls, bench)

    :ok
  end

  def loop(0,_) do :ok end
  def loop(n, f) do
    f.()
    loop(n-1, f)
  end

  def list_new() do
    []
  end
  def list_insert(e, []) do
    [e]

  end
  def list_insert(e, l) do
    [h | t] = l
 #   case e do
  #    e > h -> [h | list_insert(e, t)]
  #    e <= h -> [e | l]
    #end
    if(e > h) do
      [h | list_insert(e, t)]
    else
      [e | l]
    end
  end

  def tree_new() do
    :nil
  end

  # node, key, value, left, right
  # key and value are for new values, k and v for old

  def tree_insert(key, value, :nil) do
    {:node, key, value, :nil, :nil}
  end

  def tree_insert(key, value, {:node, k, v, left, right}) do
    if(key < k ) do
      {:node, k, v, tree_insert(key, value, left), right}
    else
      {:node, k, v, left, tree_insert(key, value, right)}
    end
  end

  def sorted_test() do
    list = []
    list = list_insert(5, list)
    list = list_insert(6, list)
    list = list_insert(3, list)
    [h|t] = list
    [h|t] = t
    IO.write("#{h}")
    tree = tree_new()
    tree = tree_insert(50,50,tree)
    tree = tree_insert(20,20,tree)
    tree = tree_insert(30,30,tree)
    tree = tree_insert(70,70,tree)
    t1 = elem(tree,2)
    IO.write("#{t1}")
  end
end
