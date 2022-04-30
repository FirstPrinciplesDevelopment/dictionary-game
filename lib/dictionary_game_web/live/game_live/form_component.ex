defmodule DictionaryGameWeb.GameLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Games
  alias DictionaryGame.Dictionary

  @impl true
  def update(%{game: game} = assigns, socket) do
    changeset = Games.change_game(game)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"game" => game_params}, socket) do
    changeset =
      socket.assigns.game
      |> Games.change_game(game_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("create_game", %{"game" => game_params}, socket) do
    # Create game if one doesn't already exist.
    case Games.create_game(game_params) do
      {:ok, game} ->
        # Fetch an initial word.
        word = Dictionary.get_unknown_word!(game.id)
        # Create initial round.
        Games.create_round(game, word, %{round_number: 1})

        # Broadcast game_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "game_created", game)

        {:noreply, socket |> push_redirect(to: Routes.game_show_path(socket, :show, game))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
