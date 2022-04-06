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

  @doc """
  Generate a round.
  """
  def round_fixture(attrs \\ %{}) do
    {:ok, round} =
      attrs
      |> Enum.into(%{
        round_number: 42
      })
      |> DictionaryGame.Games.create_round()

    round
  end

  @doc """
  Generate a score.
  """
  def score_fixture(attrs \\ %{}) do
    {:ok, score} =
      attrs
      |> Enum.into(%{
        score: 42
      })
      |> DictionaryGame.Games.create_score()

    score
  end

  @doc """
  Generate a played_word.
  """
  def played_word_fixture(attrs \\ %{}) do
    {:ok, played_word} =
      attrs
      |> Enum.into(%{})
      |> DictionaryGame.Games.create_played_word()

    played_word
  end

  @doc """
  Generate a known_words.
  """
  def known_words_fixture(attrs \\ %{}) do
    {:ok, known_words} =
      attrs
      |> Enum.into(%{})
      |> DictionaryGame.Games.create_known_words()

    known_words
  end

  @doc """
  Generate a player_word_approval.
  """
  def player_word_approval_fixture(attrs \\ %{}) do
    {:ok, player_word_approval} =
      attrs
      |> Enum.into(%{})
      |> DictionaryGame.Games.create_player_word_approval()

    player_word_approval
  end

  @doc """
  Generate a player_definition_votes.
  """
  def player_definition_votes_fixture(attrs \\ %{}) do
    {:ok, player_definition_votes} =
      attrs
      |> Enum.into(%{})
      |> DictionaryGame.Games.create_player_definition_vote()

    player_definition_votes
  end
end
