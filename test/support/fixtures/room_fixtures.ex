defmodule DictionaryGame.RoomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.Rooms` context.
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
      |> DictionaryGame.Rooms.create_room()

    room
  end

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        is_host: true,
        name: "some name"
      })
      |> DictionaryGame.Rooms.create_player()

    player
  end

  @doc """
  Generate a unique definition word.
  """
  def unique_definition_word, do: "some word#{System.unique_integer([:positive])}"
end
