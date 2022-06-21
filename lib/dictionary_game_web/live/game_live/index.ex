defmodule DictionaryGameWeb.GameLive.Index do
  use DictionaryGameWeb, :live_view
  require Logger

  alias DictionaryGame.Games
  alias Phoenix.LiveView.JS

  @impl true
  def mount(_params, session, socket) do
    topic = "games"

    if connected?(socket) do
      DictionaryGameWeb.Endpoint.subscribe(topic)
    end

    # TODO: remove :topic if unused
    {:ok,
     socket
     |> assign(
       games: Games.list_public_game_info(),
       user_id: session["user_id"],
       topic: topic
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Create Or Join A Game")
     |> assign(:game, %Games.Game{})}
  end

  @impl true
  def handle_info(%{event: "game_created", payload: game}, socket) do
    # Add new game to game list.
    {:noreply,
     assign(socket,
       games: socket.assigns.games ++ [Games.get_game_info!(game.id)]
     )}
  end

  @impl true
  def handle_info(%{event: "game_deleted", payload: game_id}, socket) do
    {:noreply,
     assign(socket,
       games: Enum.reject(socket.assigns.games, &(&1.id == game_id))
     )}
  end

  @impl true
  def handle_info(%{event: "players_online", payload: game_id}, socket) do
    {:noreply,
     assign(socket,
       games:
         Enum.reject(socket.assigns.games, &(&1.id == game_id)) ++ [Games.get_game_info!(game_id)]
     )}
  end
end
