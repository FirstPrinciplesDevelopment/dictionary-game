defmodule DictionaryGameWeb.GameLive.GameHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  def bg_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "bg-blue-100"
      {false, true} -> "bg-teal-100"
      {_, false} -> "bg-gray-100"
    end
  end

  def text_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "text-blue-900"
      {false, true} -> "text-teal-900"
      {_, false} -> "text-gray-900"
    end
  end

  def border_color(is_current_player, online) do
    case {is_current_player, online} do
      {true, true} -> "border-blue-500"
      {false, true} -> "border-teal-600"
      {_, false} -> "border-gray-500"
    end
  end
end
