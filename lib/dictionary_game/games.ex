defmodule DictionaryGame.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.Dictionary.{Word, Definition}
  alias DictionaryGame.Games.{Game, Round, Player}

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
  Returns the list of public games.

  ## Examples

      iex> list_public_games()
      [%Game{}, ...]

  """
  def list_public_games do
    Repo.all(from r in Game, where: r.is_public)
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

  # @doc """
  # Gets the game for a game_id or creates a game if one doesn't exist.

  # ## Examples

  #     iex> get_or_create_game(game_id, %{field: value})
  #     {:ok, %Game{}}

  #     iex> get_or_create_game(game_id, %{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # """
  # def get_or_create_game(game_id, attrs \\ %{}) do
  #   case Repo.get_by(Game, game_id: game_id) do
  #     %Game{} = game ->
  #       {:ok, game}

  #     nil ->
  #       %Game{game_id: game_id}
  #       |> Game.changeset(attrs)
  #       |> Repo.insert()
  #   end
  # end

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

  alias DictionaryGame.Games.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Returns the list of players in a game.

  ## Examples

      iex> list_players(game_id)
      [%Player{}, ...]

  """
  def list_players(game_id) do
    Repo.all(from p in Player, where: p.game_id == ^game_id)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Gets a single player by user_id and game_id.

  Returns `nil` if no result was found.

  ## Examples

      iex> get_player!(game_id, user_id)
      %Player{}

      iex> get_player!(game_id, user_id)
      nil

  """
  def get_player(game_id, user_id), do: Repo.get_by(Player, user_id: user_id, game_id: game_id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(game_id, user_id, %{field: value})
      {:ok, %Player{}}

      iex> create_player(game_id, user_id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(game_id, user_id, attrs \\ %{}) do
    %Player{game_id: game_id, user_id: user_id}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end

  @doc """
  Increments a player's score by amount.

  ## Examples

      iex> increment_player_score(score, amount)
      {:ok, %Player{}}

      iex> increment_player_score(score, amount)
      {:error, %Ecto.Changeset{}}

  """
  def increment_player_score(%Player{id: id}, amount) do
    {1, [player]} =
      from(p in Player, where: p.id == ^id, select: p)
      |> Repo.update_all(inc: [score: amount])

    {:ok, player}
  end

  @doc """
  Increments a player's display_score by amount.

  ## Examples

      iex> increment_player_display_score(score, amount)
      {:ok, %Player{}}

      iex> increment_player_display_score(score, amount)
      {:error, %Ecto.Changeset{}}

  """
  def increment_player_display_score(%Player{id: id}, amount) do
    {1, [player]} =
      from(p in Player, where: p.id == ^id, select: p)
      |> Repo.update_all(inc: [display_score: amount])

    {:ok, player}
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
