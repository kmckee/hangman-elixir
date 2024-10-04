defmodule B2Web.Live.Game.WordSoFar do
  use B2Web, :live_component

  @states %{
    already_used: "You already used that letter",
    bad_guess: "Bad guess",
    good_guess: "Good guess",
    initializing: "Type or click on your first guess",
    lost: "You lost...",
    won: "You won!"
  }

  defp state_name(state) do
    Map.get(@states, state, "Unknown state")
  end

  def mount(socket) do
   {:ok, socket}
  end

  def render(assigns) do
  ~H"""
  <div class="word-so-far">
    <div class="game-state">
      <%= state_name(@tally.game_state) %>
    </div>
    <div class="letters">
    <%= for ch <- @tally.letters do %>
      <% cls = if ch != "_", do: "one-letter correct", else: "one-letter" %>
        <div class={cls}>
          <%= ch %>
        </div>
    <% end %>
    </div>
  </div>
  """
end
end
