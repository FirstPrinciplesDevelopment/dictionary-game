defmodule DictionaryGame.DictionaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DictionaryGame.Dictionary` context.
  """

  @doc """
  Generate a unique word word.
  """
  def unique_word_word, do: "some word#{System.unique_integer([:positive])}"

  @doc """
  Generate a word.
  """
  def word_fixture(attrs \\ %{}) do
    {:ok, word} =
      attrs
      |> Enum.into(%{
        part_of_speech: "some part_of_speech",
        word: unique_word_word()
      })
      |> DictionaryGame.Dictionary.create_word()

    word
  end

  @doc """
  Generate a definition.
  """
  def definition_fixture(attrs \\ %{}) do
    {:ok, definition} =
      attrs
      |> Enum.into(%{
        definition: "some definition",
        is_real: true
      })
      |> DictionaryGame.Dictionary.create_definition()

    definition
  end
end
