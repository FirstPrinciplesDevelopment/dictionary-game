defmodule DictionaryGameWeb.RoomLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Room
  alias DictionaryGame.Room.Player

  require Logger

  @impl true
  def mount(%{"room_code" => room_code}, session, socket) do
    # Get a player by room_code and user_id
    player = Room.get_player(Room.get_room_by_room_code!(room_code).id, session["user_id"])

    topic = "room:" <> room_code

    if connected?(socket) do
      DictionaryGameWeb.Endpoint.subscribe(topic)

      if player do
        DictionaryGameWeb.Presence.track(self(), topic, player.name, %{})
      end
    end

    {:ok,
     socket
     |> assign(
       player: player || %Player{},
       user_id: session["user_id"],
       topic: topic,
       player_list: [],
       temporary_assigns: [player_list: []]
     )}
  end

  @impl true
  def handle_params(%{"room_code" => room_code}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action, room_code))
     |> assign(:room, Room.get_room_by_room_code!(room_code))}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    Logger.info(joins: joins, leaves: leaves)

    player_list = DictionaryGameWeb.Presence.list(socket.assigns.topic) |> Map.keys()
    Logger.info(player_list: player_list)

    {:noreply, assign(socket, player_list: player_list)}
  end

  @impl true
  def handle_event("start_game", _value, socket) do
    game_state = %{}
    {:noreply, assign(socket, :game_state, game_state)}
  end

  defp page_title(:show, room_code), do: "Room: #{room_code}"
end
