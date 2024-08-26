defmodule Hangman.Runtime.Server do
  @type t :: pid()

  alias Hangman.Impl.Game

  use GenServer

  @me __MODULE__

  ### Used by Client Process
  def start_link(_) do
    GenServer.start_link(@me, nil)
  end

  ### Used by Server Process

  def init(_) do
    game = Game.new_game()
    {:ok, game}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    tally = Game.tally(game)
    {:reply, tally, game}
  end
end
