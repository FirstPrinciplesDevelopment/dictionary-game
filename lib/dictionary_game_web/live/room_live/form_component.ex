defmodule DictionaryGameWeb.RoomLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Game

  @impl true
  def update(%{room: room} = assigns, socket) do
    changeset = Game.change_room(room)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"room" => room_params}, socket) do
    changeset =
      socket.assigns.room
      |> Game.change_room(room_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("create_or_join", %{"room" => room_params}, socket) do
    case Game.create_or_get_room(room_params) do
      {:ok, room} ->
        {:noreply,
         socket
         |> put_flash(:info, "Joining")
         |> push_redirect(to: Routes.room_show_path(socket, :show, room.room_code))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
