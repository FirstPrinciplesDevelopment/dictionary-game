defmodule DictionaryGameWeb.RoomLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Rooms

  @impl true
  def update(%{room: room} = assigns, socket) do
    changeset = Rooms.change_room(room)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"room" => room_params}, socket) do
    changeset =
      socket.assigns.room
      |> Rooms.change_room(room_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("create_room", %{"room" => room_params}, socket) do
    case Rooms.create_room(room_params) do
      {:ok, room} ->
        DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "room_created", room)

        {:noreply,
         socket
         |> put_flash(:info, "Joining")
         |> push_redirect(to: Routes.room_show_path(socket, :show, room.id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
