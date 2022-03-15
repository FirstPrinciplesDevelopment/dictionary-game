defmodule DictionaryGameWeb.PlayerLive.Index do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Game
  alias DictionaryGame.Game.Player

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:players, list_players())
     |> assign(:user_id, session["user_id"])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, _action, _params) do
    socket
    |> assign(:page_title, "Players")
    |> assign(:player, %Player{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    player = Game.get_player!(id)
    {:ok, _} = Game.delete_player(player)

    {:noreply, assign(socket, :players, list_players())}
  end

  defp list_players do
    Game.list_players()
  end
end
