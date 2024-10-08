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
    IO.puts("You won!")
    :ok
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost.  The word was: #{tally.letters |> Enum.join()}")
    :ok
  end

  def interact({game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    tally = Hangman.make_move(game, get_guess())
    interact({game, tally})
  end

  def feedback_for(tally = %{game_state: :initializing}),
    do: "Welcome to hangman!  I'm thinking of a #{tally.letters |> Enum.count()} letter word."

  def feedback_for(_tally = %{game_state: :good_guess}), do: "Good guess!"
  def feedback_for(_tally = %{game_state: :bad_guess}), do: "Nope!"

  def feedback_for(_tally = %{game_state: :already_used}),
    do: "Looks like you already tried that one.  Try again."

  def current_word(tally) do
    IO.puts([
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      " .   turns left: ",
      tally.turns_left |> to_string(),
      " .   used: ",
      tally.used |> Enum.join(", ")
    ])
  end

  def get_guess() do
    IO.gets("Next letter: ")
    |> to_string()
    |> String.trim()
    |> String.downcase()
  end
end
