defmodule DictionaryGameWeb.DefinitionLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Dictionary

  @impl true
  def update(%{definition: definition} = assigns, socket) do
    changeset = Dictionary.change_definition(definition)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"definition" => definition_params}, socket) do
    changeset =
      socket.assigns.definition
      |> Dictionary.change_definition(definition_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"definition" => definition_params}, socket) do
    save_definition(socket, socket.assigns.action, definition_params)
  end

  defp save_definition(socket, :new, definition_params) do
    case Dictionary.create_definition(
           socket.assigns.player,
           socket.assigns.round.word,
           definition_params
         ) do
      {:ok, definition} ->
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "definition_created",
          definition
        )

        {:noreply,
         socket
         |> put_flash(:info, "Definition created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
