defmodule DictionaryGame.DictionaryTest do
  use DictionaryGame.DataCase

  alias DictionaryGame.Dictionary

  describe "words" do
    alias DictionaryGame.Dictionary.Word

    import DictionaryGame.DictionaryFixtures

    @invalid_attrs %{part_of_speech: nil, word: nil}

    test "list_words/0 returns all words" do
      word = word_fixture()
      assert Dictionary.list_words() == [word]
    end

    test "get_word!/1 returns the word with given id" do
      word = word_fixture()
      assert Dictionary.get_word!(word.id) == word
    end

    test "create_word/1 with valid data creates a word" do
      valid_attrs = %{part_of_speech: "some part_of_speech", word: "some word"}

      assert {:ok, %Word{} = word} = Dictionary.create_word(valid_attrs)
      assert word.part_of_speech == "some part_of_speech"
      assert word.word == "some word"
    end

    test "create_word/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_word(@invalid_attrs)
    end

    test "update_word/2 with valid data updates the word" do
      word = word_fixture()
      update_attrs = %{part_of_speech: "some updated part_of_speech", word: "some updated word"}

      assert {:ok, %Word{} = word} = Dictionary.update_word(word, update_attrs)
      assert word.part_of_speech == "some updated part_of_speech"
      assert word.word == "some updated word"
    end

    test "update_word/2 with invalid data returns error changeset" do
      word = word_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_word(word, @invalid_attrs)
      assert word == Dictionary.get_word!(word.id)
    end

    test "delete_word/1 deletes the word" do
      word = word_fixture()
      assert {:ok, %Word{}} = Dictionary.delete_word(word)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_word!(word.id) end
    end

    test "change_word/1 returns a word changeset" do
      word = word_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_word(word)
    end
  end

  describe "definitions" do
    alias DictionaryGame.Dictionary.Definition

    import DictionaryGame.DictionaryFixtures

    @invalid_attrs %{definition: nil, is_real: nil}

    test "list_definitions/0 returns all definitions" do
      definition = definition_fixture()
      assert Dictionary.list_definitions() == [definition]
    end

    test "get_definition!/1 returns the definition with given id" do
      definition = definition_fixture()
      assert Dictionary.get_definition!(definition.id) == definition
    end

    test "create_definition/1 with valid data creates a definition" do
      valid_attrs = %{definition: "some definition", is_real: true}

      assert {:ok, %Definition{} = definition} = Dictionary.create_definition(valid_attrs)
      assert definition.definition == "some definition"
      assert definition.is_real == true
    end

    test "create_definition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_definition(@invalid_attrs)
    end

    test "update_definition/2 with valid data updates the definition" do
      definition = definition_fixture()
      update_attrs = %{definition: "some updated definition", is_real: false}

      assert {:ok, %Definition{} = definition} = Dictionary.update_definition(definition, update_attrs)
      assert definition.definition == "some updated definition"
      assert definition.is_real == false
    end

    test "update_definition/2 with invalid data returns error changeset" do
      definition = definition_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_definition(definition, @invalid_attrs)
      assert definition == Dictionary.get_definition!(definition.id)
    end

    test "delete_definition/1 deletes the definition" do
      definition = definition_fixture()
      assert {:ok, %Definition{}} = Dictionary.delete_definition(definition)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_definition!(definition.id) end
    end

    test "change_definition/1 returns a definition changeset" do
      definition = definition_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_definition(definition)
    end
  end
end
