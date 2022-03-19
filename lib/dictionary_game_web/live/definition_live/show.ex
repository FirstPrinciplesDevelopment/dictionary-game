defmodule DictionaryGameWeb.DefinitionLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:definition, Game.get_definition!(id))}
  end

  defp page_title(:show), do: "Show Definition"
  defp page_title(:edit), do: "Edit Definition"
end
