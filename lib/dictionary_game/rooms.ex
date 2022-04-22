defmodule DictionaryGame.Rooms do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.Rooms.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Returns the list of public rooms.

  ## Examples

      iex> list_public_rooms()
      [%Room{}, ...]

  """
  def list_public_rooms do
    Repo.all(from r in Room, where: r.is_public)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  alias DictionaryGame.Rooms.Player

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
  Returns the list of players in a room.

  ## Examples

      iex> list_players(room_id)
      [%Player{}, ...]

  """
  def list_players(room_id) do
    Repo.all(from p in Player, where: p.room_id == ^room_id)
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
  Gets a single player by user_id and room_id.

  Returns `nil` if no result was found.

  ## Examples

      iex> get_player!(room_id, user_id)
      %Player{}

      iex> get_player!(room_id, user_id)
      nil

  """
  def get_player(room_id, user_id), do: Repo.get_by(Player, user_id: user_id, room_id: room_id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(room_id, user_id, %{field: value})
      {:ok, %Player{}}

      iex> create_player(room_id, user_id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(room_id, user_id, attrs \\ %{}) do
    %Player{room_id: room_id, user_id: user_id}
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
end
