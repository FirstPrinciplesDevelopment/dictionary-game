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
    # Get the existing room or nil if it doesn't exist.
    room = Game.get_room_by_room_code(room_params["room_code"])

    if !room do
      # Create the room since it doesn't exist.
      case Game.create_room(room_params) do
        {:ok, room} ->
          {:noreply,
           socket
           |> put_flash(:info, "Created room")
           |> push_redirect(to: Routes.room_show_path(socket, :show, room.room_code))}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
      end
    else
      # Join the room.
      {:noreply,
       socket
       |> put_flash(:info, "Joining room")
       |> push_redirect(to: Routes.room_show_path(socket, :show, room.room_code))}
    end
  end
end
