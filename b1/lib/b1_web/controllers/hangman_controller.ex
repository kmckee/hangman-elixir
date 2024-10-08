defmodule B1Web.HangmanController do
  use B1Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def new(conn, _params) do
    game = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> redirect(to: ~p"/hangman/current")
  end

  def update(conn, params) do
    guess = params["make_move"]["guess"]

    get_session(conn, :game)
    |> Hangman.make_move(guess)

    redirect(conn, to: ~p"/hangman/current")
  end

  def show(conn, _params) do
    tally = conn |> get_session(:game) |> Hangman.tally()

    render(conn, :new, tally: tally)
  end
end
