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
     |> assign(games: list_games(), user_id: session["user_id"], topic: topic)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(%{event: "game_created", payload: game}, socket) do
    Logger.info(payload: game)
    # Add new game to game list.
    {:noreply, assign(socket, games: socket.assigns.games ++ [game])}
  end

  defp apply_action(socket, _action, _params) do
    socket
    |> assign(:page_title, "Create Or Join A Game")
    |> assign(:game, %Games.Game{})
  end

  defp list_games do
    Games.list_public_games()
  end
end
