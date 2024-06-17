defmodule Kyle do
  def swap({a, b}), do: {b, a}
  def same?(a, a), do: true
  def same?(_, _), do: false

  def len([]), do: 0
  def len([_ | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double([h | t]), do: [h * 2 | double(t)]

  def sum_pairs([]), do: []
  def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]
  def sum_pairs([_]), do: raise("odd number of elements")
end
