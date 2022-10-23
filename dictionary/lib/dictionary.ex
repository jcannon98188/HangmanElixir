defmodule Dictionary do
  @spec start() :: list(String.t())
  defdelegate start(), to: Dictionary.Impl.WordList

  @spec random_word(list(String.t())) :: String.t()
  defdelegate random_word(word_list), to: Dictionary.Impl.WordList
  # @word_list "assets/words.txt"
  #   |> File.read!()
  #   |> String.split(~r/\n/, trim: true)

  # def random_word do
  #   @word_list
  #   |> Enum.random()
  # end
end
