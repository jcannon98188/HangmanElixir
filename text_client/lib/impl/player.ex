defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start(game) :: :ok
  def start(game) do
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok
  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congratulations. You won!")
  end

  def interact({game, _tally = %{game_state: :lost}}) do
    IO.puts("Sorry. You lost ... the word was #{game.letters |> Enum.join()}")
  end

  def interact({game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    tally = Hangman.make_move(game, get_guess())
    interact({game, tally})
  end

  defp feedback_for(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word"
  end

  defp feedback_for(_tally = %{game_state: :good_guess}) do
    "Good Guess"
  end

  defp feedback_for(_tally = %{game_state: :bad_guess}) do
    "Bad Guess"
  end

  defp feedback_for(_tally = %{game_state: :already_used}) do
    "Letter already used"
  end

  defp current_word(tally) do
    [
      "Word so far: #{tally.letters |> Enum.join(" ")}",
      "  #{IO.ANSI.green()}(turns left: #{tally.turns_left |> to_string}",
      "  used: #{IO.ANSI.yellow()}#{tally.used |> Enum.join(",")}#{IO.ANSI.green()})#{IO.ANSI.reset()}"
    ]
  end

  def get_guess() do
    IO.gets("Next Letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
