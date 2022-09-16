defmodule DictionaryGameWeb.DefinitionLive.FormComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.Dictionary
  alias DictionaryGame.ActionLogs

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

        ActionLogs.create_action_log_item(%{
          user_id: socket.assigns.user_id,
          message: "Definition created successfully",
          color: "blue",
          type: "info"
        })

        {:noreply,
         socket
         |> put_flash(:info, "Definition created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
