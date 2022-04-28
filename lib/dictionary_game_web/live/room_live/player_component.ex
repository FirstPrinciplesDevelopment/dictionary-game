defmodule DictionaryGameWeb.RoomLive.PlayerComponent do
  use DictionaryGameWeb, :live_component

  @impl true
  def update(
        %{is_current_player: is_current_player, online: online, player: player} = assigns,
        socket
      ) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       border_color: border_color(is_current_player, online),
       text_color: text_color(is_current_player, online),
       bg_color: bg_color(is_current_player, online)
     )}
  end

  defp bg_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "bg-blue-100"
      {false, true} -> "bg-teal-100"
      {_, false} -> "bg-gray-100"
    end
  end

  defp text_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "text-blue-900"
      {false, true} -> "text-teal-900"
      {_, false} -> "text-gray-900"
    end
  end

  defp border_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "border-blue-500"
      {false, true} -> "border-teal-600"
      {_, false} -> "border-gray-500"
    end
  end
end
