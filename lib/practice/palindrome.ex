defmodule Practice.Palindrome do

  def palindrome(phrase) do
    # some useful methods:
    # String.codepoints/1 will make a list of chars
    # String.reverse will reverse string
    # Sol:
    #   Make codepoints for og and reverse
    #   compare. if they are equal, its a palindrome :D.
    revphrase = String.reverse(phrase)
    phraseCodepoints = String.codepoints(phrase)
    revPhraseCodepoints = String.codepoints(revphrase)
    phraseCodepoints == revPhraseCodepoints
  end
end
