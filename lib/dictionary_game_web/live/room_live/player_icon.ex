defmodule DictionaryGameWeb.RoomLive.PlayerIcon do
  use DictionaryGameWeb, :live_component
  alias DictionaryGameWeb.RoomLive.RoomHelpers

  @impl true
  def update(
        %{is_current_player: is_current_player, online: online, player: player} = assigns,
        socket
      ) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       border_color: RoomHelpers.border_color(is_current_player, online),
       text_color: RoomHelpers.text_color(is_current_player, online),
       bg_color: RoomHelpers.bg_color(is_current_player, online)
     )}
  end
end
