defmodule DictionaryGameWeb.GameLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Games

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
    case Games.create_game(game_params) do
      {:ok, game} ->
        DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "game_created", game)

        {:noreply,
         socket
         |> put_flash(:info, "Joining")
         |> push_redirect(to: Routes.game_show_path(socket, :show, game.id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
