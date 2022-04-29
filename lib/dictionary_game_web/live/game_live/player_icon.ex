defmodule DictionaryGameWeb.GameLive.PlayerIcon do
  use DictionaryGameWeb, :live_component
  alias DictionaryGameWeb.GameLive.GameHelpers

  @impl true
  def update(
        %{is_current_player: is_current_player, online: online, player: player} = assigns,
        socket
      ) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       border_color: GameHelpers.border_color(is_current_player, online),
       text_color: GameHelpers.text_color(is_current_player, online),
       bg_color: GameHelpers.bg_color(is_current_player, online)
     )}
  end
end
