defmodule DictionaryGameWeb.RoomLive.Index do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Game
  alias DictionaryGame.Game.Room
  alias Phoenix.LiveView.JS

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
    |> assign(:page_title, "Create Or Join A Room")
    |> assign(:room, %Room{})
  end

  defp list_rooms do
    Game.list_rooms()
  end
end
