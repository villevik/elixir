defmodule Program do
  def read_instruction(code, pc) do
    elem(code, pc)
  end
  def load() do
    ##{List.to_tuple(test())}
  end
  def test() do
   {
      {:addi, 1, 1, 5},
      {:add, 2, 1, 1},
      {:sub, 3, 2, 1},
      {:addi, 4, 1, 2},
      {:addi, 4, 4, 3},
      {:sw, 4, 2, 1},
      {:lw, 5, 2, 1},
      {:out, 3},
      {:beq, 2, 4, -4},
      {:out, 5},
      {:halt}
  }
  end
end
#{:sw, 4, rd, imm},
      #{:lw, rd, rs, imm},
