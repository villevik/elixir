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

      {:sub, rd, rs, rt} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s - t)
        run(pc, code, reg, mem)

      {:addi, rd, rs, imm} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        reg = Register.write(reg, rd, s + imm)
        run(pc, code, reg, mem)

      {:lw, rd, rs, imm} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        addr = s + imm
        val = Register.read(reg, addr)
        reg = Register.write(reg, rd, val)
        run(pc, code, mem, reg, out)

      {:sw, rs, rd, imm} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        addr = rd + imm
        reg = Register.write(reg, addr, s)
        run(pc, code, mem, reg, out)

      {:beq, rs, rt, imm} ->
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        pc = if a == b do
          pc+imm
        else
          pc + 4 end
        run(pc, code, mem, reg, out)

      {:out, rs} ->
        pc = pc + 4
        s = Register.read(rs)
        out = Out.put(out, s)
        run(pc, code, reg, mem, out)
    end
  end
end
