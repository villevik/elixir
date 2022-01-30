defmodule Deriv do
  @type literal() :: {:num, number()} | {:var, atom()}

  @type expr() :: literal()
  | {:add, expr(), expr()}    #Addition
  | {:mul, expr(), expr()}    #Multiplication
  | {:exp, expr(), literal()} #Exponent
  | {:sin, expr()}
  | {:ln, expr()}

  def test1() do
    # 2x + 4
    e = {:add,
        {:mul, {:num, 2}, {:var, :x}},
        {:num, 4}}
    d1 = deriv(e, :x)
    IO.write("Exression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d1)}\n")
    IO.write("Simplified: #{pprint(simplify(d1))}\n")
    :ok
  end

  def test2() do
    # 2x + 4
    e = {:add,
        {:exp, {:var, :x}, {:num, 2}},
        {:num, 4}}
    d1 = deriv(e, :x)
    IO.write("Exression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d1)}\n")
    IO.write("Simplified: #{pprint(simplify(d1))}\n")
    :ok
  end

  def test3() do
    # 1/x
    e1 = {:div, {:num, 1}, {:var, :x}}
    e2 = {:exp, {:var, :x}, {:num, 0.5}}
    e3 = {:ln, {:var, :x}}
    e4 = {:sin, {:var, :x}}
    e = e4
    d = deriv(e, :x)
    IO.write("Exression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    :ok
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end

  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end
  def deriv({:mul, e1, e2}, v) do
    {:add,
    {:mul, deriv(e1, v), e2},
    {:mul, e1, deriv(e2, v)}}
  end

  def deriv({:div, _, {:num, 0}}, v) do "error" end
  def deriv({:div, {:num, numerator}, {:num, denominator}}, _) do {:num, 0} end
  def deriv({:div, {:num, 0}, _}, v) do {:num, 0} end
  def deriv({:div, {:var, :x}, {:num, denominator}}, x) do
    {:div, {:num, 1}, {:num, denominator}}
  end
  def deriv({:div, {:num, numerator}, {:var, :x}}, x) do
    {:mul, {:mul, {:num, -1}, {:num, numerator}}, {:exp, {:var, x}, {:num, -2}}}
  end
  def deriv({:div, {:var, numerator}, {:var, denominator}}, x) do
    {:div,
     {:add,
     {:mul, deriv(numerator, x), denominator},
     {:mul, -deriv(denominator, x), numerator}},
     {:exp, denominator, {:num, 2}}}
  end

  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
      deriv(e,v)
    }
  end

  def deriv({:ln, {:var, :x}}, x) do
    {:div, {:num, 1}, {:var, :x}}
  end

  def deriv({:sin, {:var, :x}}, x) do
    {:cos, {:var, :x}}
  end


  def simplify({:add,e1,e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul,e1,e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
  def simplify(e) do e end

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, 1}, e1) do e1 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_div({:num, 0}, e) do {:num, 0} end
  def simplify_div({:var, x}, denominator) do {:div, {:num, 1}, {denominator}} end
  def simplify_div({:num, numerator}, {:var, x}) do {:div, {:num, numerator}, {:var, x}} end
  def simplify_div({:num, n}) do {:num, n} end
  def simplify_div({:num, numerator}, {:num, denominator}) do {:div, {:num, numerator}, {:num, denominator}} end
  def simplify_div(e1, e2) do {:num, e1 / e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1,n2)} end
  def simplify_exp(e1,e2) do {:exp, e1, e2} end

  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)})^(#{pprint(e2)})" end
  def pprint({:div, numerator, denominator}) do "( #{pprint(numerator)} / #{pprint(denominator)} )" end
  def pprint({:div, {:num, numerator}, {:num, denominator}}) do "( #{pprint(numerator)} / #{pprint(denominator)} )" end
  def pprint({:ln, e}) do "( ln #{pprint(e)} )" end
  def pprint({:cos, {:var, x}}) do "cos x" end
  def pprint({:sin, {:var, x}}) do "sin x" end
end
