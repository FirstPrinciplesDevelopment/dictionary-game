defmodule DictionaryGameWeb.DefinitionLive.Index do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.Game
  alias DictionaryGame.Game.Definition

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :definitions, list_definitions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Definition")
    |> assign(:definition, Game.get_definition!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Definition")
    |> assign(:definition, %Definition{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Definitions")
    |> assign(:definition, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    definition = Game.get_definition!(id)
    {:ok, _} = Game.delete_definition(definition)

    {:noreply, assign(socket, :definitions, list_definitions())}
  end

  defp list_definitions do
    Game.list_definitions()
  end
end
