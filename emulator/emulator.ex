defmodule Emulator do
  def run()  do
    code = Program.test()
    mem = []
    reg = Register.new()
    out = []
    run(0, code, reg, mem, out)
  end

  def run(pc, code, reg, mem, out) do
    next = Program.read_instruction(code, pc)
    case next do
      {:halt} ->
        Out.close(out)

      {:add, rd, rs, rt} ->
        pc = pc + 1
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s + t)
        run(pc, code, reg, mem, out)

      {:sub, rd, rs, rt} ->
        pc = pc + 1
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s - t)
        run(pc, code, reg, mem, out)

      {:addi, rd, rs, imm} ->
        pc = pc + 1
        s = Register.read(reg, rs)
        reg = Register.write(reg, rd, s + imm)
        run(pc, code, reg, mem, out)

      {:lw, rd, rs, imm} ->
        pc = pc + 1
        s = Register.read(reg, rs)
        addr = s + imm
        val = Memory.read(mem, addr)
        reg = Register.write(reg, rd, val)
        run(pc, code, reg, mem, out)

      {:sw, rs, rd, imm} ->
        pc = pc + 1
        s = Register.read(reg, rs)
        d = Register.read(reg, rd)
        addr = d + imm
        mem = Memory.write(mem, addr, s)
        run(pc, code, reg, mem, out)

      {:beq, rs, rt, imm} ->
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        pc = if s == t do
          pc+imm
        else
          pc + 1
        end
        run(pc, code, reg, mem, out)

      {:out, rs} ->
        pc = pc + 1
        s = Register.read(reg,rs)
        out = Out.put(out, s)
        run(pc, code, reg, mem, out)
    end
  end
end
#cd("OneDrive/Dokument/elixir/emulator")
#c("memory.ex")
#c("register.ex")
#c("program.ex")
#c("out.ex")
#c("emulator.ex")
#Emulator.run()
