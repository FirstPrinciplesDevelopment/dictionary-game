defmodule DictionaryGameWeb.ActionLogItemLive.ActionLogComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.ActionLogs

  @impl true
  def update(assigns, socket) do
    action_log_items = ActionLogs.list_action_log_items(assigns.user_id)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:action_log_items, action_log_items)}
  end

  @impl true
  def handle_event("validate", %{"action_log_item" => action_log_item_params}, socket) do
    changeset =
      socket.assigns.action_log_item
      |> ActionLogs.change_action_log_item(action_log_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
