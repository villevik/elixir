defmodule Huffman do
  def bench() do
    texts = [text(), sample(), read("kallocain.txt")]
    IO.write("#{bench(text())}#{bench(read("kallocain.txt"))}")
  end
  def bench(h) do
    sample = h
    {treetime, :ok} = :timer.tc(fn -> tree(sample)
    :ok end)
    tree = tree(sample)
    {encodetime, :ok} = :timer.tc(fn -> encode_table(tree)
    :ok end)
    encode = encode_table(tree)
    {decodetabletime, :ok} = :timer.tc(fn -> decode_table(tree)
    :ok end)
    decode = decode_table(tree)
    text = h
    {sequencetime, :ok} = :timer.tc(fn -> encode(text, encode)
    :ok end)
    seqence = encode(text, encode)
    {decodetime, :ok} = :timer.tc(fn -> decode(seqence, decode)
    :ok end)
    readable = decode(seqence, decode)
    IO.write("number of characters: #{Enum.count(h)}\ntime to create tree: #{treetime}\ntime to encode table: #{encodetime}\ntime to decode table: #{decodetabletime}\ntime to encode text: #{sequencetime}\ntime to decode sequence: #{decodetime}\n\n")
    :ok
  end
  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)

    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, _} -> list
      list -> list
    end
  end
  def sample() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end
  #The text to be encoded
  def text() do
    'hello my name is ville'
  end
  def test() do
    sample = sample()
    IO.write("#{Enum.count(sample)}")
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end
  #The code for inserting the elements in the tree
  # x and y in sorted is the amount of the characters, which is being compared
  def tree(text) do
    freq = freq(text)
    #huffman(freq)
    sorted = Enum.sort(freq, fn({_,x},{_,y}) -> x < y end)
    huffman_tree(sorted)
  end
  #Get the frequency of each character in the text, time: O(n) + update()
  def freq(text) do
    freq(text,[])
  end
  def freq([], freq) do freq end
  def freq([char| rest], freq) do
    freq(rest, update(char, freq))
  end
  #Update the frequency/value of the char with +1 , time: Worst case: amount of different characters that has been read(freq-list), Best case: 1
  def update(char, []) do
    [{char,1}]
  end
  #Pattern-matching, char first gets its value in the first parameter and if the tuple matches
  #this is the function invoked.
  def update(char, [{char, n} | freq]) do
    [{char, n+1} | freq]
  end
  def update(char, [h|t]) do
    [h | update(char, t)]
  end
  #construct the branches and leaves, time: O(n)
  def huffman_tree([{c, n}]) do c end
  def huffman_tree([{c1, n1}|[{c2, n2}|t]]) do
    huffman_tree(insert({{c1,c2}, n1+n2}, t))
  end
  #If freq of n2 is smaller go to next index, time: O(n)
  def insert({c1, n1}, [{c2, n2}|t]) do
    if n1 > n2 do
      [{c2,n2}|insert({c1,n1}, t)]
    else
      [{c1,n1}, {c2,n2}|t]
    end
  end
  def insert({c1, n1}, []) do
    [{c1,n1}]
  end

  def encode_table(tree) do
    encode_table(tree,[])
  end
  def encode_table({left, right}, tab) do
    encode_table(left, [0 | tab]) ++ encode_table(right, [1 | tab])
  end
  def encode_table(branch, [h|t]) do
    [{branch, Enum.reverse([h|t])}]
  end


  def encode([], table) do [] end
  def encode([h|t], table) do
    find(h, table) ++ encode(t, table)
  end

  def find(e, [{e,n}|t]) do n end
  def find(e, [{c,n}|t]) do
    find(e, t)
  end

  def decode_table(tree) do tree end
  #Pattern matching
  def decode(seq, tree) do
    decode(seq, tree, tree)
  end
  def decode([], char, _) do
    [char]
  end
  def decode([0 | seq], {left, _}, tree) do
    decode(seq, left, tree)
  end
  def decode([1 | seq], {_, right}, tree) do
    decode(seq, right, tree)
  end
  def decode(seq, char, tree) do
    [char | decode(seq, tree, tree)]
  end

end
#'Hello my name is Ville'
#{
#  {
#    {105, 109},       #i, m freq:2
#    {
#      {97, 110},      #a, n freq:1
#      {86, 115}       #V, s freq:1
#    }
#  }
#  , #right
#  {
#    {
#      {
#        72,           #H freq:1
#        {121, 111}    #y, o freq:1
#      },
#      101             #e freq:3
#    },
#    {32, 108}         #[space], l freq:4
#  }
#}
