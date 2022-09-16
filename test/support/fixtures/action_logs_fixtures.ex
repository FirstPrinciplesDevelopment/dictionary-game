defmodule DictionaryGame.ActionLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.ActionLogs` context.
  """

  @doc """
  Generate a action_log_item.
  """
  def action_log_item_fixture(attrs \\ %{}) do
    {:ok, action_log_item} =
      attrs
      |> Enum.into(%{
        color: "some color",
        message: "some message",
        type: "some type",
        user_id: "some user_id"
      })
      |> DictionaryGame.ActionLogs.create_action_log_item()

    action_log_item
  end
end
