defmodule DictionaryGameWeb.RoomLive.Index do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Game
  alias DictionaryGame.Game.Room

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rooms, list_rooms())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, _action, _params) do
    socket
    |> assign(:page_title, "Rooms")
    |> assign(:room, %Room{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    room = Game.get_room!(id)
    {:ok, _} = Game.delete_room(room)

    {:noreply, assign(socket, :rooms, list_rooms())}
  end

  defp list_rooms do
    Game.list_rooms()
  end
end
