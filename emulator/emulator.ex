defmodule Emulator do
  def run(prgm)  do
    {code, data} = Program.load(prgm)
    reg = Registers.new()
    run(0, code, reg, data)
  end

  def run(pc, code, reg, mem) do
    next = Program.read_instruction(code, pc)
    case next do
      :halt ->
        Out.close(out)

      {:add, rd, rs, rt} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s + t)
        run(pc, code, reg, mem)

      {:out, rs} ->
        pc = pc + 4
        s = Register.read(rs)
        out = Out.put(out, s)
        run(pc, code, reg, mem, out)
    end
  end
end
