defmodule TextClient.Runtime.RemoteHangman do
  @remote_server "hangman@Kyles-MacBook-Pro" |> String.to_atom()
  def connect() do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end
end
