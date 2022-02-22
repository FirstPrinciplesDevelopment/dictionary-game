defmodule DictionaryGame.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.Game` context.
  """

  @doc """
  Generate a unique room room_code.
  """
  def unique_room_room_code, do: "some room_code#{System.unique_integer([:positive])}"

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        room_code: unique_room_room_code()
      })
      |> DictionaryGame.Game.create_room()

    room
  end
end
