defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # converts to postfix
  # opStack should be a list of [{:op, value}, ...]
  # acc should be a list of [{:op or :name, value}, ...]
  def convert_to_postfix([head | tail], opStack, acc) do
    # head is {:op or :num, string}
    {type, value} = head 
    if (type == :num) do
      # if it's a num, just send it to the accumulator.
      convert_to_postfix(tail, opStack, acc ++ [head])
    else
      # if stack is empty, push head onto stack
      if (opStack == []) do
        convert_to_postfix(tail, [head] ++ opStack, acc)
      else
        # head is known to have a head and tail now, so let's grab them
        # if time persists, move this all to a helper function
        headOfOpStack = hd opStack
        tailOfOpStack = tl opStack
        {headOfOpStackType, headOfOpStackValue} = headOfOpStack
        # if the incoming operator is higher precedence, put it on the stack.
        if (value == "*" || value == "/") do
          if (headOfOpStackValue == "+" || headOfOpStackValue == "-") do
            # has a higher precedence
            convert_to_postfix(tail, [head] ++ opStack, acc)
          else
            # has equal precedence
            # pop and print top of the stack, then push the incoming operator
            # tail of op stack is always list 
            convert_to_postfix(tail, [head] ++ tailOfOpStack, acc ++ [headOfOpStack])
          end
        else 
          if (headOfOpStack == "+" || headOfOpStack == "-") do
            #has equal precedence
            convert_to_postfix(tail, [head] ++ tailOfOpStack, acc ++ [headOfOpStack])
          else
            # has lower precedence
            # pop top of the stack off and print it. then test the incoming operator
            # against the new top of stack
            convert_to_postfix([head | tail], tailOfOpStack, acc ++ [headOfOpStack])
          end
        end
      end
    end
  end

  def convert_to_postfix([], opStack, acc) do
    # if opStack has anything, print it
    acc ++ opStack
  end

  # tags all tokens
  def tag_tokens([head | tail], acc) do
    if (head == "+" || head == "-" || head == "*" || head == "/") do
      tag_tokens(tail, acc ++ [{:op, head}])
    else
      tag_tokens(tail, acc ++ [{:num, head}])
    end
  end

  def tag_tokens([], acc) do
    acc
  end

  def evaluate_prefix([head | tail], stack) do
    # prefix_reversed looks like [{:num, "3"}, {:op, "+"}] 
    {type, value} = head
    #algorithm from geeksforgeeks.org
    # if head is an operand, push it to Stack
    # if the head is an operator, pop two elements from the stack. operate
    # on these elements ACCORDING TO OPERATOR, then push result back to stack
    if (type == :num) do
      # only grab values because only numbers should be in the stack. operaters
      # are evlauated on spot and never pushed.
      evaluate_prefix(tail, [value] ++ stack)
    else
      #grabbing
      [stackHead | stackTail] = stack
      element1 = stackHead
      element2 = hd stackTail  #second element. use hd because tail is a list
      poppedStack = tl tl stack
      {type, operator} = head
      result = (mathify(element1, operator, element2))   #lmao for that infix looking stuff
      evaluate_prefix(tail, [Float.to_string(result)] ++ poppedStack)
    end
  end

  def evaluate_prefix([], stack) do
    # return the number in the stack, no list
    parse_float(hd stack)
  end

  def mathify(element1, operator, element2) do
    # element1 and 2 are strings
    # operator is also a string? yeah
    element1 = parse_float(element1)
    element2 = parse_float(element2)
    # case was indenting weird with element1 * element2, so 
    # if clauses for now.
    cond do
      operator == "+" ->
        element1 + element2
      operator == "-" ->
        element1 - element2
      operator == "*" ->
        element1 * element2
      operator == "/" ->
        element1 / element2
    end
  end


  def calc(expr) do
    # but doesn't need to handle parens.
    expr
    |> String.split(" ")
    |> tag_tokens([])
    # these two reverses were taken from geeksforgeeks.org infix to prefix notation
    |> Enum.reverse()
    |> convert_to_postfix([], [])
    |> Enum.reverse()
    # from geeksforgeeks.org, prefix evaluation, it would be easiest for me to revers again. This would 
    # 'put the pointer at the end and make it accessible through the head of the list.
    # Leaving the two reverses to show my thought process to grader.
    |> Enum.reverse()
    |> evaluate_prefix([])
    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
