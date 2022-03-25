defmodule DictionaryGame.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  alias DictionaryGame.Games.Round

  @doc """
  Returns the list of rounds.

  ## Examples

      iex> list_rounds()
      [%Round{}, ...]

  """
  def list_rounds do
    Repo.all(Round)
  end

  @doc """
  Gets a single round.

  Raises `Ecto.NoResultsError` if the Round does not exist.

  ## Examples

      iex> get_round!(123)
      %Round{}

      iex> get_round!(456)
      ** (Ecto.NoResultsError)

  """
  def get_round!(id), do: Repo.get!(Round, id)

  @doc """
  Creates a round.

  ## Examples

      iex> create_round(%{field: value})
      {:ok, %Round{}}

      iex> create_round(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_round(attrs \\ %{}) do
    %Round{}
    |> Round.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a round.

  ## Examples

      iex> update_round(round, %{field: new_value})
      {:ok, %Round{}}

      iex> update_round(round, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_round(%Round{} = round, attrs) do
    round
    |> Round.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a round.

  ## Examples

      iex> delete_round(round)
      {:ok, %Round{}}

      iex> delete_round(round)
      {:error, %Ecto.Changeset{}}

  """
  def delete_round(%Round{} = round) do
    Repo.delete(round)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking round changes.

  ## Examples

      iex> change_round(round)
      %Ecto.Changeset{data: %Round{}}

  """
  def change_round(%Round{} = round, attrs \\ %{}) do
    Round.changeset(round, attrs)
  end

  alias DictionaryGame.Games.Score

  @doc """
  Returns the list of scores.

  ## Examples

      iex> list_scores()
      [%Score{}, ...]

  """
  def list_scores do
    Repo.all(Score)
  end

  @doc """
  Gets a single score.

  Raises `Ecto.NoResultsError` if the Score does not exist.

  ## Examples

      iex> get_score!(123)
      %Score{}

      iex> get_score!(456)
      ** (Ecto.NoResultsError)

  """
  def get_score!(id), do: Repo.get!(Score, id)

  @doc """
  Creates a score.

  ## Examples

      iex> create_score(%{field: value})
      {:ok, %Score{}}

      iex> create_score(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_score(attrs \\ %{}) do
    %Score{}
    |> Score.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a score.

  ## Examples

      iex> update_score(score, %{field: new_value})
      {:ok, %Score{}}

      iex> update_score(score, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_score(%Score{} = score, attrs) do
    score
    |> Score.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a score.

  ## Examples

      iex> delete_score(score)
      {:ok, %Score{}}

      iex> delete_score(score)
      {:error, %Ecto.Changeset{}}

  """
  def delete_score(%Score{} = score) do
    Repo.delete(score)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking score changes.

  ## Examples

      iex> change_score(score)
      %Ecto.Changeset{data: %Score{}}

  """
  def change_score(%Score{} = score, attrs \\ %{}) do
    Score.changeset(score, attrs)
  end

  alias DictionaryGame.Games.PlayedWords

  @doc """
  Returns the list of played_words.

  ## Examples

      iex> list_played_words()
      [%PlayedWords{}, ...]

  """
  def list_played_words do
    Repo.all(PlayedWords)
  end

  @doc """
  Gets a single played_words.

  Raises `Ecto.NoResultsError` if the Played words does not exist.

  ## Examples

      iex> get_played_words!(123)
      %PlayedWords{}

      iex> get_played_words!(456)
      ** (Ecto.NoResultsError)

  """
  def get_played_words!(id), do: Repo.get!(PlayedWords, id)

  @doc """
  Creates a played_words.

  ## Examples

      iex> create_played_words(%{field: value})
      {:ok, %PlayedWords{}}

      iex> create_played_words(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_played_words(attrs \\ %{}) do
    %PlayedWords{}
    |> PlayedWords.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a played_words.

  ## Examples

      iex> update_played_words(played_words, %{field: new_value})
      {:ok, %PlayedWords{}}

      iex> update_played_words(played_words, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_played_words(%PlayedWords{} = played_words, attrs) do
    played_words
    |> PlayedWords.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a played_words.

  ## Examples

      iex> delete_played_words(played_words)
      {:ok, %PlayedWords{}}

      iex> delete_played_words(played_words)
      {:error, %Ecto.Changeset{}}

  """
  def delete_played_words(%PlayedWords{} = played_words) do
    Repo.delete(played_words)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking played_words changes.

  ## Examples

      iex> change_played_words(played_words)
      %Ecto.Changeset{data: %PlayedWords{}}

  """
  def change_played_words(%PlayedWords{} = played_words, attrs \\ %{}) do
    PlayedWords.changeset(played_words, attrs)
  end

  alias DictionaryGame.Games.KnownWords

  @doc """
  Returns the list of known_words.

  ## Examples

      iex> list_known_words()
      [%KnownWords{}, ...]

  """
  def list_known_words do
    Repo.all(KnownWords)
  end

  @doc """
  Gets a single known_words.

  Raises `Ecto.NoResultsError` if the Known words does not exist.

  ## Examples

      iex> get_known_words!(123)
      %KnownWords{}

      iex> get_known_words!(456)
      ** (Ecto.NoResultsError)

  """
  def get_known_words!(id), do: Repo.get!(KnownWords, id)

  @doc """
  Creates a known_words.

  ## Examples

      iex> create_known_words(%{field: value})
      {:ok, %KnownWords{}}

      iex> create_known_words(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_known_words(attrs \\ %{}) do
    %KnownWords{}
    |> KnownWords.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a known_words.

  ## Examples

      iex> update_known_words(known_words, %{field: new_value})
      {:ok, %KnownWords{}}

      iex> update_known_words(known_words, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_known_words(%KnownWords{} = known_words, attrs) do
    known_words
    |> KnownWords.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a known_words.

  ## Examples

      iex> delete_known_words(known_words)
      {:ok, %KnownWords{}}

      iex> delete_known_words(known_words)
      {:error, %Ecto.Changeset{}}

  """
  def delete_known_words(%KnownWords{} = known_words) do
    Repo.delete(known_words)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking known_words changes.

  ## Examples

      iex> change_known_words(known_words)
      %Ecto.Changeset{data: %KnownWords{}}

  """
  def change_known_words(%KnownWords{} = known_words, attrs \\ %{}) do
    KnownWords.changeset(known_words, attrs)
  end

  alias DictionaryGame.Games.PlayerWordApproval

  @doc """
  Returns the list of player_word_approvals.

  ## Examples

      iex> list_player_word_approvals()
      [%PlayerWordApproval{}, ...]

  """
  def list_player_word_approvals do
    Repo.all(PlayerWordApproval)
  end

  @doc """
  Gets a single player_word_approval.

  Raises `Ecto.NoResultsError` if the Player word approval does not exist.

  ## Examples

      iex> get_player_word_approval!(123)
      %PlayerWordApproval{}

      iex> get_player_word_approval!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_word_approval!(id), do: Repo.get!(PlayerWordApproval, id)

  @doc """
  Creates a player_word_approval.

  ## Examples

      iex> create_player_word_approval(%{field: value})
      {:ok, %PlayerWordApproval{}}

      iex> create_player_word_approval(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_word_approval(attrs \\ %{}) do
    %PlayerWordApproval{}
    |> PlayerWordApproval.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player_word_approval.

  ## Examples

      iex> update_player_word_approval(player_word_approval, %{field: new_value})
      {:ok, %PlayerWordApproval{}}

      iex> update_player_word_approval(player_word_approval, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_word_approval(%PlayerWordApproval{} = player_word_approval, attrs) do
    player_word_approval
    |> PlayerWordApproval.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_word_approval.

  ## Examples

      iex> delete_player_word_approval(player_word_approval)
      {:ok, %PlayerWordApproval{}}

      iex> delete_player_word_approval(player_word_approval)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_word_approval(%PlayerWordApproval{} = player_word_approval) do
    Repo.delete(player_word_approval)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_word_approval changes.

  ## Examples

      iex> change_player_word_approval(player_word_approval)
      %Ecto.Changeset{data: %PlayerWordApproval{}}

  """
  def change_player_word_approval(%PlayerWordApproval{} = player_word_approval, attrs \\ %{}) do
    PlayerWordApproval.changeset(player_word_approval, attrs)
  end

  alias DictionaryGame.Games.PlayerDefinitionVotes

  @doc """
  Returns the list of player_definition_votes.

  ## Examples

      iex> list_player_definition_votes()
      [%PlayerDefinitionVotes{}, ...]

  """
  def list_player_definition_votes do
    Repo.all(PlayerDefinitionVotes)
  end

  @doc """
  Gets a single player_definition_votes.

  Raises `Ecto.NoResultsError` if the Player definition votes does not exist.

  ## Examples

      iex> get_player_definition_votes!(123)
      %PlayerDefinitionVotes{}

      iex> get_player_definition_votes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_definition_votes!(id), do: Repo.get!(PlayerDefinitionVotes, id)

  @doc """
  Creates a player_definition_votes.

  ## Examples

      iex> create_player_definition_votes(%{field: value})
      {:ok, %PlayerDefinitionVotes{}}

      iex> create_player_definition_votes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_definition_votes(attrs \\ %{}) do
    %PlayerDefinitionVotes{}
    |> PlayerDefinitionVotes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player_definition_votes.

  ## Examples

      iex> update_player_definition_votes(player_definition_votes, %{field: new_value})
      {:ok, %PlayerDefinitionVotes{}}

      iex> update_player_definition_votes(player_definition_votes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_definition_votes(%PlayerDefinitionVotes{} = player_definition_votes, attrs) do
    player_definition_votes
    |> PlayerDefinitionVotes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_definition_votes.

  ## Examples

      iex> delete_player_definition_votes(player_definition_votes)
      {:ok, %PlayerDefinitionVotes{}}

      iex> delete_player_definition_votes(player_definition_votes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_definition_votes(%PlayerDefinitionVotes{} = player_definition_votes) do
    Repo.delete(player_definition_votes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_definition_votes changes.

  ## Examples

      iex> change_player_definition_votes(player_definition_votes)
      %Ecto.Changeset{data: %PlayerDefinitionVotes{}}

  """
  def change_player_definition_votes(%PlayerDefinitionVotes{} = player_definition_votes, attrs \\ %{}) do
    PlayerDefinitionVotes.changeset(player_definition_votes, attrs)
  end
end
