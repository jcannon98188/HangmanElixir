defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "Produces a word in the word list" do
    word_list = File.read!("assets/words.txt") |> String.split(~r/\n/, trim: true)
    assert Dictionary.random_word() in word_list
  end
end
