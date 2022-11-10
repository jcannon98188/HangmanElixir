defmodule Dictionary do
  @spec start() :: list(String.t())
  defdelegate start(), to: Dictionary.Impl.WordList

  @spec random_word(list(String.t())) :: String.t()
  defdelegate random_word(word_list), to: Dictionary.Impl.WordList
end
