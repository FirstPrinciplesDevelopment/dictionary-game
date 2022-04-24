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
end
