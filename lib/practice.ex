defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Delegated to lib/practice/calc.ex
    Practice.Factor.factor(x)
  end

  def palindrome(phrase) do
    Practice.Palindrome.palindrome(phrase)
  end
  # DONE: Add a palindrome? function.
end
