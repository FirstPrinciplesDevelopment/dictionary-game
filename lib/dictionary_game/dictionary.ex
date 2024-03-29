defmodule DictionaryGame.Dictionary do
  @moduledoc """
  The Dictionary context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.Dictionary.{Word, Definition}
  alias DictionaryGame.Games.{Player, KnownWord, PlayedWord}

  @doc """
  Returns the list of words.

  ## Examples

      iex> list_words()
      [%Word{}, ...]

  """
  def list_words do
    Repo.all(Word)
  end

  @doc """
  Gets a single word.

  Raises `Ecto.NoResultsError` if the Word does not exist.

  ## Examples

      iex> get_word!(123)
      %Word{}

      iex> get_word!(456)
      ** (Ecto.NoResultsError)

  """
  def get_word!(id), do: Repo.get!(Word, id)

  @doc """
  Gets a single random unknown real word for a game, i.e. a word that no one in game has marked as "known".

  Raises `Ecto.NoResultsError` if the Word does not exist.

  ## Examples

      iex> get_unknown_word!(game_id)
      %Word{}

      iex> get_unknown_word!(game_id)
      ** (Ecto.NoResultsError)

  """
  def get_unknown_word!(game_id) do
    query =
      from w in Word,
        left_join: kw in KnownWord,
        on: w.id == kw.word_id,
        left_join: pw in PlayedWord,
        on: w.id == pw.word_id,
        where:
          (is_nil(kw.game_id) or kw.game_id != ^game_id) and
            (is_nil(pw.game_id) or pw.game_id != ^game_id) and
            w.is_real

    hd(Enum.shuffle(Repo.all(query)))
  end

  @doc """
  Creates a word.

  ## Examples

      iex> create_word(%{field: value})
      {:ok, %Word{}}

      iex> create_word(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_word(attrs \\ %{}) do
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a word along with its real definition.

  ## Examples

      iex> create_real_word_and_definition(%{field: value})
      {:ok, %Word{}}

      iex> create_real_word_and_definition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_real_word_and_definition(%{
        "word" => word,
        "part_of_speech" => part_of_speech,
        "definition" => definition
      }) do
    case %Word{word: word, part_of_speech: part_of_speech, is_real: true}
         |> Word.changeset(%{})
         |> Repo.insert() do
      {:ok, word} ->
        %Definition{definition: definition, is_real: true}
        |> Definition.changeset(%{})
        |> Ecto.Changeset.put_assoc(:word, word)
        |> Repo.insert()

        {:ok, word}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a word.

  ## Examples

      iex> update_word(word, %{field: new_value})
      {:ok, %Word{}}

      iex> update_word(word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_word(%Word{} = word, attrs) do
    word
    |> Word.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a word.

  ## Examples

      iex> delete_word(word)
      {:ok, %Word{}}

      iex> delete_word(word)
      {:error, %Ecto.Changeset{}}

  """
  def delete_word(%Word{} = word) do
    Repo.delete(word)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking word changes.

  ## Examples

      iex> change_word(word)
      %Ecto.Changeset{data: %Word{}}

  """
  def change_word(%Word{} = word, attrs \\ %{}) do
    Word.changeset(word, attrs)
  end

  @doc """
  Returns the list of definitions.

  ## Examples

      iex> list_definitions()
      [%Definition{}, ...]

  """
  def list_definitions do
    Repo.all(Definition)
  end

  @doc """
  Returns the list of definitions for a game and word,
  comprising the real definition of the word and the player submitted definitions.

  ## Examples

      iex> list_definitions(game_id, word_id)
      [%Definition{}, ...]

  """
  def list_definitions(game_id, word_id) do
    query =
      from d in Definition,
        left_join: p in Player,
        on: d.player_id == p.id,
        where:
          d.word_id == ^word_id and (p.game_id == ^game_id or (d.is_real and is_nil(d.player_id)))

    Repo.all(query)
  end

  @doc """
  Gets a single definition.

  Raises `Ecto.NoResultsError` if the Definition does not exist.

  ## Examples

      iex> get_definition!(123)
      %Definition{}

      iex> get_definition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_definition!(id), do: Repo.get!(Definition, id)

  @doc """
  Gets a real definition for a word_id.

  Raises `Ecto.NoResultsError` if the Definition does not exist.

  ## Examples

      iex> get_real_definition!(word_id)
      %Definition{}

      iex> get_real_definition!(word_id)
      ** (Ecto.NoResultsError)

  """
  def get_real_definition!(word_id) do
    Repo.get_by!(Definition, word_id: word_id, is_real: true)
  end

  @doc """
  Gets a single definition by player_id and word_id.

  Returns `nil` if the Definition does not exist.

  ## Examples

      iex> get_definition!(player_id, word_id)
      %Definition{}

      iex> get_definition!(player_id, word_id)
      ** (Ecto.NoResultsError)

  """
  def get_definition(player_id, word_id) do
    Repo.get_by(Definition, player_id: player_id, word_id: word_id)
  end

  @doc """
  Creates a definition.

  ## Examples

      iex> create_definition(%{field: value})
      {:ok, %Definition{}}

      iex> create_definition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_definition(attrs \\ %{}) do
    %Definition{}
    |> Definition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a definition.

  ## Examples

      iex> create_definition(player, word, %{field: value})
      {:ok, %Definition{}}

      iex> create_definition(player, word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_definition(%Player{} = player, %Word{} = word, attrs \\ %{}) do
    %Definition{}
    |> Definition.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:player, player)
    |> Ecto.Changeset.put_assoc(:word, word)
    |> Repo.insert()
  end

  @doc """
  Updates a definition.

  ## Examples

      iex> update_definition(definition, %{field: new_value})
      {:ok, %Definition{}}

      iex> update_definition(definition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_definition(%Definition{} = definition, attrs) do
    definition
    |> Definition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a definition.

  ## Examples

      iex> delete_definition(definition)
      {:ok, %Definition{}}

      iex> delete_definition(definition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_definition(%Definition{} = definition) do
    Repo.delete(definition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking definition changes.

  ## Examples

      iex> change_definition(definition)
      %Ecto.Changeset{data: %Definition{}}

  """
  def change_definition(%Definition{} = definition, attrs \\ %{}) do
    Definition.changeset(definition, attrs)
  end
end
