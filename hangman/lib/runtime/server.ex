defmodule Hangman.Runtime.Server do
  alias Hangman.Runtime.Watchdog
  alias Hangman.Impl.Game

  @type t :: pid()

  @idle_timeout 1 * 60 * 60 * 1000

  use GenServer

  @me __MODULE__

  ### Used by Client Process
  def start_link(_) do
    GenServer.start_link(@me, nil)
  end

  ### Used by Server Process

  def init(_) do
    IO.puts("Starting Hangman Server")
    watcher = Watchdog.start(@idle_timeout)
    game = Game.new_game()
    {:ok, {game, watcher}}
  end

  def handle_call({:make_move, guess}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, {updated_game, watcher}}
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    tally = Game.tally(game)
    {:reply, tally, {game, watcher}}
  end
end
