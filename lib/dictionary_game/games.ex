defmodule DictionaryGame.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.{Rooms, Dictionary}
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
  Gets a single game by room id.

  Returns `nil` if the Game does not exist.

  ## Examples

      iex> get_game!(room_id)
      %Game{}

      iex> get_game!(room_id)
      ** (Ecto.NoResultsError)

  """
  def get_game(room_id), do: Repo.get_by(Game, room_id: room_id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(room_id, %{field: value})
      {:ok, %Game{}}

      iex> create_game(room_id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(room_id, attrs \\ %{}) do
    %Game{room_id: room_id}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets the game for a room_id or creates a game if one doesn't exist.

  ## Examples

      iex> get_or_create_game(room_id, %{field: value})
      {:ok, %Game{}}

      iex> get_or_create_game(room_id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_or_create_game(room_id, attrs \\ %{}) do
    case Repo.get_by(Game, room_id: room_id) do
      %Game{} = game ->
        {:ok, game}

      nil ->
        %Game{room_id: room_id}
        |> Game.changeset(attrs)
        |> Repo.insert()
    end
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

  alias DictionaryGame.Games.PlayedWord

  @doc """
  Returns the list of played_words.

  ## Examples

      iex> list_played_words()
      [%PlayedWord{}, ...]

  """
  def list_played_words do
    Repo.all(PlayedWord)
  end

  @doc """
  Gets a single played_words.

  Raises `Ecto.NoResultsError` if the Played words does not exist.

  ## Examples

      iex> get_played_words!(123)
      %PlayedWord{}

      iex> get_played_words!(456)
      ** (Ecto.NoResultsError)

  """
  def get_played_words!(id), do: Repo.get!(PlayedWord, id)

  @doc """
  Creates a played_words.

  ## Examples

      iex> create_played_words(%{field: value})
      {:ok, %PlayedWord{}}

      iex> create_played_words(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_played_words(attrs \\ %{}) do
    %PlayedWord{}
    |> PlayedWord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a played_words.

  ## Examples

      iex> update_played_words(played_words, %{field: new_value})
      {:ok, %PlayedWord{}}

      iex> update_played_words(played_words, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_played_words(%PlayedWord{} = played_words, attrs) do
    played_words
    |> PlayedWord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a played_words.

  ## Examples

      iex> delete_played_words(played_words)
      {:ok, %PlayedWord{}}

      iex> delete_played_words(played_words)
      {:error, %Ecto.Changeset{}}

  """
  def delete_played_words(%PlayedWord{} = played_words) do
    Repo.delete(played_words)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking played_words changes.

  ## Examples

      iex> change_played_words(played_words)
      %Ecto.Changeset{data: %PlayedWord{}}

  """
  def change_played_words(%PlayedWord{} = played_words, attrs \\ %{}) do
    PlayedWord.changeset(played_words, attrs)
  end

  alias DictionaryGame.Games.KnownWord

  @doc """
  Returns the list of known_words.

  ## Examples

      iex> list_known_words()
      [%KnownWord{}, ...]

  """
  def list_known_words do
    Repo.all(KnownWord)
  end

  @doc """
  Gets a single known_words.

  Raises `Ecto.NoResultsError` if the Known words does not exist.

  ## Examples

      iex> get_known_words!(123)
      %KnownWord{}

      iex> get_known_words!(456)
      ** (Ecto.NoResultsError)

  """
  def get_known_words!(id), do: Repo.get!(KnownWord, id)

  @doc """
  Creates a known_words.

  ## Examples

      iex> create_known_words(%{field: value})
      {:ok, %KnownWord{}}

      iex> create_known_words(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_known_words(attrs \\ %{}) do
    %KnownWord{}
    |> KnownWord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a known_words.

  ## Examples

      iex> update_known_words(known_words, %{field: new_value})
      {:ok, %KnownWord{}}

      iex> update_known_words(known_words, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_known_words(%KnownWord{} = known_words, attrs) do
    known_words
    |> KnownWord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a known_words.

  ## Examples

      iex> delete_known_words(known_words)
      {:ok, %KnownWord{}}

      iex> delete_known_words(known_words)
      {:error, %Ecto.Changeset{}}

  """
  def delete_known_words(%KnownWord{} = known_words) do
    Repo.delete(known_words)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking known_words changes.

  ## Examples

      iex> change_known_words(known_words)
      %Ecto.Changeset{data: %KnownWord{}}

  """
  def change_known_words(%KnownWord{} = known_words, attrs \\ %{}) do
    KnownWord.changeset(known_words, attrs)
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

  alias DictionaryGame.Games.PlayerDefinitionVote

  @doc """
  Returns the list of player_definition_votes.

  ## Examples

      iex> list_player_definition_votes()
      [%PlayerDefinitionVote{}, ...]

  """
  def list_player_definition_votes do
    Repo.all(PlayerDefinitionVote)
  end

  @doc """
  Gets a single player_definition_votes.

  Raises `Ecto.NoResultsError` if the Player definition votes does not exist.

  ## Examples

      iex> get_player_definition_votes!(123)
      %PlayerDefinitionVote{}

      iex> get_player_definition_votes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_definition_votes!(id), do: Repo.get!(PlayerDefinitionVote, id)

  @doc """
  Creates a player_definition_votes.

  ## Examples

      iex> create_player_definition_votes(%{field: value})
      {:ok, %PlayerDefinitionVote{}}

      iex> create_player_definition_votes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_definition_votes(attrs \\ %{}) do
    %PlayerDefinitionVote{}
    |> PlayerDefinitionVote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player_definition_votes.

  ## Examples

      iex> update_player_definition_votes(player_definition_votes, %{field: new_value})
      {:ok, %PlayerDefinitionVote{}}

      iex> update_player_definition_votes(player_definition_votes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_definition_votes(%PlayerDefinitionVote{} = player_definition_votes, attrs) do
    player_definition_votes
    |> PlayerDefinitionVote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_definition_votes.

  ## Examples

      iex> delete_player_definition_votes(player_definition_votes)
      {:ok, %PlayerDefinitionVote{}}

      iex> delete_player_definition_votes(player_definition_votes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_definition_votes(%PlayerDefinitionVote{} = player_definition_votes) do
    Repo.delete(player_definition_votes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_definition_votes changes.

  ## Examples

      iex> change_player_definition_votes(player_definition_votes)
      %Ecto.Changeset{data: %PlayerDefinitionVote{}}

  """
  def change_player_definition_votes(
        %PlayerDefinitionVote{} = player_definition_votes,
        attrs \\ %{}
      ) do
    PlayerDefinitionVote.changeset(player_definition_votes, attrs)
  end
end