defmodule DictionaryGame.RoomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.Rooms` context.
  """

  @doc """
  Generate a unique room name.
  """
  def unique_room_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_censored: true,
        is_public: true,
        name: unique_room_name()
      })
      |> DictionaryGame.Rooms.create_room()

    room
  end
end
