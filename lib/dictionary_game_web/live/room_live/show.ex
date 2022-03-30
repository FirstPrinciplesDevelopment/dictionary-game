defmodule DictionaryGameWeb.RoomLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.{Rooms, Games, Dictionary}
  alias DictionaryGame.Rooms.Player

  require Logger

  @impl true
  def mount(%{"id" => room_id}, session, socket) do
    # Get the room by room id.
    room = Rooms.get_room!(room_id)
    # Get a player by room id and user_id.
    player = Rooms.get_player(room.id, session["user_id"])
    # Get the game if it exists.
    game = Games.get_game(room.id)

    topic = "room:" <> room_id

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
  def handle_params(%{"id" => room_id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action, room_id))
     |> assign(:room, Rooms.get_room!(room_id))}
  end

  @impl true
  def handle_info(%{event: "game_created", payload: game}, socket) do
    Logger.info(payload: game)

    {:noreply, socket |> assign(game: game) |> put_flash(:info, "Game started.")}
  end

  @impl true
  def handle_info(%{event: "game_deleted", payload: delete_by}, socket) do
    {:noreply,
     socket |> assign(game: nil) |> put_flash(:info, "Game ended by #{delete_by.name}.")}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    Logger.info(joins: joins, leaves: leaves)

    player_list = DictionaryGameWeb.Presence.list(socket.assigns.topic) |> Map.keys()
    Logger.info(player_list: player_list)

    {:noreply, socket |> assign(player_list: player_list)}
  end

  @impl true
  def handle_event("start_game", _value, socket) do
    # Create game if one doesn't already exist.
    case Games.get_or_create_game(socket.assigns.room.id) do
      {:ok, game} ->
        # TODO: Create round
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast game_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "game_created", game)
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("end_game", _value, socket) do
    # Delete game.
    case Games.delete_game(socket.assigns.game) do
      {:ok, game} ->
        # TODO: Make sure delete cascades properly.
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast game_deleted event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "game_deleted",
          socket.assigns.player
        )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # TODO: make room name?
  defp page_title(:show, room_id), do: "Room: #{room_id}"
end
