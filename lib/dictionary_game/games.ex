defmodule DictionaryGame.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.Rooms
  alias DictionaryGame.Rooms.{Player}
  alias DictionaryGame.Dictionary.{Word, Definition}
  alias DictionaryGame.Games.{Game, Round}

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
  Gets the current round for a game_id.

  Returns `nil` if the Round does not exist.

  ## Examples

      iex> get_current_round(123)
      %Round{}

      iex> get_current_round(456)
      nil

  """
  def get_current_round(game_id) do
    # TODO: make sure frist(order_by) is working - https://hexdocs.pm/ecto/Ecto.Query.html#first/2
    query =
      from r in Round,
        where: r.game_id == ^game_id,
        order_by: [desc: r.round_number],
        preload: [:word]

    query
    |> first()
    |> Repo.one()
  end

  @doc """
  Creates a round.

  ## Examples

      iex> create_round(%{field: value})
      {:ok, %Round{}}

      iex> create_round(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_round(%Game{} = game, %Word{} = word, attrs \\ %{}) do
    %Round{}
    |> Round.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:game, game)
    |> Ecto.Changeset.put_assoc(:word, word)
    |> Repo.insert()
  end

  @doc """
  Updates a round.

  ## Examples

      iex> update_round(round, word, %{field: new_value})
      {:ok, %Round{}}

      iex> update_round(round, word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_round(%Round{} = round, %Word{} = word, attrs \\ %{}) do
    round
    |> Round.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:word, word)
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
  Gets a single score by game and player ids.

  Raises `Ecto.NoResultsError` if the Score does not exist.

  ## Examples

      iex> get_score!(game_id, player_id)
      %Score{}

      iex> get_score!(game_id, player_id)
      ** (Ecto.NoResultsError)

  """
  def get_score(game_id, player_id),
    do: Repo.get_by(Score, game_id: game_id, player_id: player_id)

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
  Increments a score by amount.

  ## Examples

      iex> increment_score(score, amount)
      {:ok, %Score{}}

      iex> increment_score(score, amount)
      {:error, %Ecto.Changeset{}}

  """
  def increment_score(%Score{id: id}, amount) do
    {1, [score]} =
      from(s in Score, where: s.id == ^id, select: s)
      |> Repo.update_all(inc: [score: amount])

    {:ok, score}
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
  Returns the list of played_word.

  ## Examples

      iex> list_played_words()
      [%PlayedWord{}, ...]

  """
  def list_played_words do
    Repo.all(PlayedWord)
  end

  @doc """
  Gets a single played_word.

  Raises `Ecto.NoResultsError` if the Played words does not exist.

  ## Examples

      iex> get_played_word!(123)
      %PlayedWord{}

      iex> get_played_word!(456)
      ** (Ecto.NoResultsError)

  """
  def get_played_word!(id), do: Repo.get!(PlayedWord, id)

  @doc """
  Creates a played_word.

  ## Examples

      iex> create_played_word(game, word, %{field: value})
      {:ok, %PlayedWord{}}

      iex> create_played_word(game, word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_played_word(%Game{} = game, %Word{} = word, attrs \\ %{}) do
    %PlayedWord{}
    |> PlayedWord.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:game, game)
    |> Ecto.Changeset.put_assoc(:word, word)
    |> Repo.insert()
  end

  @doc """
  Updates a played_word.

  ## Examples

      iex> update_played_word(played_word, %{field: new_value})
      {:ok, %PlayedWord{}}

      iex> update_played_word(played_word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_played_word(%PlayedWord{} = played_word, attrs) do
    played_word
    |> PlayedWord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a played_word.

  ## Examples

      iex> delete_played_word(played_word)
      {:ok, %PlayedWord{}}

      iex> delete_played_word(played_word)
      {:error, %Ecto.Changeset{}}

  """
  def delete_played_word(%PlayedWord{} = played_word) do
    Repo.delete(played_word)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking played_word changes.

  ## Examples

      iex> change_played_word(played_word)
      %Ecto.Changeset{data: %PlayedWord{}}

  """
  def change_played_word(%PlayedWord{} = played_word, attrs \\ %{}) do
    PlayedWord.changeset(played_word, attrs)
  end

  alias DictionaryGame.Games.KnownWord

  @doc """
  Returns the list of known_word.

  ## Examples

      iex> list_known_word()
      [%KnownWord{}, ...]

  """
  def list_known_word do
    Repo.all(KnownWord)
  end

  @doc """
  Gets a single known_word.

  Raises `Ecto.NoResultsError` if the Known words does not exist.

  ## Examples

      iex> get_known_word!(123)
      %KnownWord{}

      iex> get_known_word!(456)
      ** (Ecto.NoResultsError)

  """
  def get_known_word!(id), do: Repo.get!(KnownWord, id)

  @doc """
  Creates a known_word.

  ## Examples

      iex> create_known_word(%{field: value})
      {:ok, %KnownWord{}}

      iex> create_known_word(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_known_word(%Game{} = game, %Word{} = word, attrs \\ %{}) do
    %KnownWord{}
    |> KnownWord.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:game, game)
    |> Ecto.Changeset.put_assoc(:word, word)
    |> Repo.insert()
  end

  @doc """
  Updates a known_word.

  ## Examples

      iex> update_known_word(known_word, %{field: new_value})
      {:ok, %KnownWord{}}

      iex> update_known_word(known_word, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_known_word(%KnownWord{} = known_word, attrs) do
    known_word
    |> KnownWord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a known_word.

  ## Examples

      iex> delete_known_word(known_word)
      {:ok, %KnownWord{}}

      iex> delete_known_word(known_word)
      {:error, %Ecto.Changeset{}}

  """
  def delete_known_word(%KnownWord{} = known_word) do
    Repo.delete(known_word)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking known_word changes.

  ## Examples

      iex> change_known_word(known_word)
      %Ecto.Changeset{data: %KnownWord{}}

  """
  def change_known_word(%KnownWord{} = known_word, attrs \\ %{}) do
    KnownWord.changeset(known_word, attrs)
  end

  alias DictionaryGame.Games.PlayerWordApproval

  @doc """
  Returns the list of player_word_approvals for a round_id.

  ## Examples

      iex> list_player_word_approvals(round_id)
      [%PlayerWordApproval{}, ...]

  """
  def list_player_word_approvals(round_id) do
    Repo.all(from p in PlayerWordApproval, where: p.round_id == ^round_id)
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

      iex> create_player_word_approval(player, word, round, %{field: value})
      {:ok, %PlayerWordApproval{}}

      iex> create_player_word_approval(player, word, round, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_word_approval(
        %Player{} = player,
        %Word{} = word,
        %Round{} = round,
        attrs \\ %{}
      ) do
    %PlayerWordApproval{}
    |> PlayerWordApproval.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:player, player)
    |> Ecto.Changeset.put_assoc(:round, round)
    |> Ecto.Changeset.put_assoc(:word, word)
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
  Returns the list of player_definition_votes for a round.

  ## Examples

      iex> list_player_definition_votes(round_id)
      [%PlayerDefinitionVote{}, ...]

  """
  def list_player_definition_votes(round_id) do
    Repo.all(from p in PlayerDefinitionVote, where: p.round_id == ^round_id)
  end

  @doc """
  Gets a single player_definition_votes.

  Raises `Ecto.NoResultsError` if the Player definition votes does not exist.

  ## Examples

      iex> get_player_definition_vote!(123)
      %PlayerDefinitionVote{}

      iex> get_player_definition_vote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_definition_vote!(id), do: Repo.get!(PlayerDefinitionVote, id)

  @doc """
  Creates a player_definition_votes.

  ## Examples

      iex> create_player_definition_vote(player, definition, round, %{field: value})
      {:ok, %PlayerDefinitionVote{}}

      iex> create_player_definition_vote(player, definition, round, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_definition_vote(
        %Player{} = player,
        %Definition{} = definition,
        %Round{} = round,
        attrs \\ %{}
      ) do
    %PlayerDefinitionVote{}
    |> PlayerDefinitionVote.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:player, player)
    |> Ecto.Changeset.put_assoc(:definition, definition)
    |> Ecto.Changeset.put_assoc(:round, round)
    |> Repo.insert()
  end

  @doc """
  Updates a player_definition_votes.

  ## Examples

      iex> update_player_definition_vote(player_definition_votes, %{field: new_value})
      {:ok, %PlayerDefinitionVote{}}

      iex> update_player_definition_vote(player_definition_votes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_definition_vote(%PlayerDefinitionVote{} = player_definition_votes, attrs) do
    player_definition_votes
    |> PlayerDefinitionVote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_definition_votes.

  ## Examples

      iex> delete_player_definition_vote(player_definition_votes)
      {:ok, %PlayerDefinitionVote{}}

      iex> delete_player_definition_vote(player_definition_votes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_definition_vote(%PlayerDefinitionVote{} = player_definition_votes) do
    Repo.delete(player_definition_votes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_definition_votes changes.

  ## Examples

      iex> change_player_definition_vote(player_definition_votes)
      %Ecto.Changeset{data: %PlayerDefinitionVote{}}

  """
  def change_player_definition_vote(
        %PlayerDefinitionVote{} = player_definition_votes,
        attrs \\ %{}
      ) do
    PlayerDefinitionVote.changeset(player_definition_votes, attrs)
  end
end
