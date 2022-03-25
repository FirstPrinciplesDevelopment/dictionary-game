defmodule DictionaryGameWeb.RoomLive.Index do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Room
  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:rooms, list_rooms())
     |> assign(:user_id, session["user_id"])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, _action, _params) do
    socket
    |> assign(:page_title, "Create Or Join A Room")
    |> assign(:room, %Room.Room{})
  end

  defp list_rooms do
    Room.list_rooms()
  end
end
