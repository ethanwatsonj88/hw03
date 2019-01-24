defmodule Practice.Factor do

  def factor(x) do
    x
    |> factor(2)  #do not need to parse; parses like double()
  end

  def factor(x, counter) when counter <= x do
    if (rem(x, counter) == 0) do 
      [counter] ++ factor(div(x, counter), 2)
    else
      factor(x, counter + 1)
    end
  end

  def factor(x, counter) when counter > x do
   [] 
  end
end
