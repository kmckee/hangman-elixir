defmodule B2Web.Live.Game do
  use B2Web, :live_view

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    {:ok, assign(socket, %{game: game, tally: tally})}
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    game = socket.assigns.game
    tally = Hangman.make_move(game, key)
    {:noreply, assign(socket, %{tally: tally})}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder" phx-window-keyup="make_move">
      <h1>Hangman</h1>
      <.live_component id="figure" module={__MODULE__.Figure} tally={assigns.tally} />
      <.live_component id="word-so-far" module={__MODULE__.WordSoFar} tally={assigns.tally} />
      <.live_component id="alphabet" module={__MODULE__.Alphabet} tally={assigns.tally} />
    </div>
    """
  end
end
