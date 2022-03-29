defmodule DictionaryGameWeb.RoomLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.{Rooms, Games, Dictionary}
  alias DictionaryGame.Rooms.Player

  require Logger

  @impl true
  def mount(%{"room_code" => room_code}, session, socket) do
    # Get the room by room_code.
    room = Rooms.get_room_by_room_code!(room_code)
    # Get a player by room_code and user_id.
    player = Rooms.get_player(room.id, session["user_id"])
    # Get the game if it exists.
    game = Games.get_game(room.id)

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
       room: room,
       game: game,
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
     |> assign(:room, Rooms.get_room_by_room_code!(room_code))}
  end

  @impl true
  def handle_info(%{event: "game_created", payload: game}, socket) do
    Logger.info(payload: game)

    {:noreply, assign(socket, game: game)}
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
    # Create game if one doesn't already exist.
    {:ok, game} = Games.get_or_create_game(socket.assigns.room.id)
    # Broadcast game_created event to other players.
    DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "game_created", game)
    {:noreply, assign(socket, :game, game)}
  end

  defp page_title(:show, room_code), do: "Room: #{room_code}"
end
