defmodule DictionaryGame.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        number_of_rounds: 42
      })
      |> DictionaryGame.Games.create_game()

    game
  end
end
