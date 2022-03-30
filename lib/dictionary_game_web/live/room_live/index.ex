defmodule DictionaryGameWeb.RoomLive.Index do
  use DictionaryGameWeb, :live_view
  require Logger

  alias DictionaryGame.Rooms
  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, session, socket) do
    topic = "rooms"

    if connected?(socket) do
      DictionaryGameWeb.Endpoint.subscribe(topic)
    end

    # TODO: remove :topic if unused
    {:ok,
     socket
     |> assign(rooms: list_rooms(), user_id: session["user_id"], topic: topic)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(%{event: "room_created", payload: room}, socket) do
    Logger.info(payload: room)
    # Add new room to room list.
    {:noreply, assign(socket, rooms: socket.assigns.rooms ++ [room])}
  end

  defp apply_action(socket, _action, _params) do
    socket
    |> assign(:page_title, "Create Or Join A Room")
    |> assign(:room, %Rooms.Room{})
  end

  defp list_rooms do
    Rooms.list_rooms()
  end
end
