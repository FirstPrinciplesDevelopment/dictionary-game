defmodule DictionaryGameWeb.ActionLogItemLive.ActionLogComponent do
  use DictionaryGameWeb, :live_component

  alias DictionaryGame.ActionLogs

  @impl true
  def update(assigns, socket) do
    action_log_items = ActionLogs.list_action_log_items(assigns.user_id)
    collapse? = socket.assigns[:collapse] || false

    {:ok,
     socket
     |> assign(assigns)
     |> assign(action_log_items: action_log_items, collapse: collapse?)}
  end

  @impl true
  def handle_event("toggle_collapse", %{}, socket) do
    collapse? = !socket.assigns[:collapse]
    {:noreply, assign(socket, :collapse, collapse?)}
  end
end
