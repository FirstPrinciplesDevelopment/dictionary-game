defmodule DictionaryGameWeb.PlayerLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Games

  @impl true
  def update(%{player: player} = assigns, socket) do
    changeset = Games.change_player(player)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"player" => player_params}, socket) do
    changeset =
      socket.assigns.player
      |> Games.change_player(player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"player" => player_params}, socket) do
    save_player(socket, socket.assigns.action, player_params)
  end

  defp save_player(socket, :new, player_params) do
    case Games.create_player(socket.assigns.game_id, socket.assigns.user_id, player_params) do
      {:ok, _player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Player created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
