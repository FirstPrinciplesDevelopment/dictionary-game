defmodule DictionaryGameWeb.DefinitionLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Game

  @impl true
  def update(%{definition: definition} = assigns, socket) do
    changeset = Game.change_definition(definition)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"definition" => definition_params}, socket) do
    changeset =
      socket.assigns.definition
      |> Game.change_definition(definition_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"definition" => definition_params}, socket) do
    save_definition(socket, socket.assigns.action, definition_params)
  end

  defp save_definition(socket, :edit, definition_params) do
    case Game.update_definition(socket.assigns.definition, definition_params) do
      {:ok, _definition} ->
        {:noreply,
         socket
         |> put_flash(:info, "Definition updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_definition(socket, :new, definition_params) do
    case Game.create_definition(definition_params) do
      {:ok, _definition} ->
        {:noreply,
         socket
         |> put_flash(:info, "Definition created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
