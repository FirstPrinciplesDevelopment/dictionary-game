defmodule DictionaryGame.ActionLogs do
  @moduledoc """
  The ActionLogs context.
  """

  import Ecto.Query, warn: false
  alias DictionaryGame.Repo

  alias DictionaryGame.ActionLogs.ActionLogItem

  @doc """
  Returns the list of action_log_items.

  ## Examples

      iex> list_action_log_items()
      [%ActionLogItem{}, ...]

  """
  def list_action_log_items do
    Repo.all(ActionLogItem)
  end

  @doc """
  Returns the list of action_log_items for a user session id.

  ## Examples

      iex> list_action_log_items(user_id)
      [%ActionLogItem{}, ...]

  """
  def list_action_log_items(user_id) do
    Repo.all(from a in ActionLogItem, where: a.user_id == ^user_id)
  end

  @doc """
  Gets a single action_log_item.

  Raises `Ecto.NoResultsError` if the Action log item does not exist.

  ## Examples

      iex> get_action_log_item!(123)
      %ActionLogItem{}

      iex> get_action_log_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action_log_item!(id), do: Repo.get!(ActionLogItem, id)

  @doc """
  Creates a action_log_item.

  ## Examples

      iex> create_action_log_item(%{field: value})
      {:ok, %ActionLogItem{}}

      iex> create_action_log_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action_log_item(attrs \\ %{}) do
    %ActionLogItem{}
    |> ActionLogItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action_log_item.

  ## Examples

      iex> update_action_log_item(action_log_item, %{field: new_value})
      {:ok, %ActionLogItem{}}

      iex> update_action_log_item(action_log_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action_log_item(%ActionLogItem{} = action_log_item, attrs) do
    action_log_item
    |> ActionLogItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a action_log_item.

  ## Examples

      iex> delete_action_log_item(action_log_item)
      {:ok, %ActionLogItem{}}

      iex> delete_action_log_item(action_log_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action_log_item(%ActionLogItem{} = action_log_item) do
    Repo.delete(action_log_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action_log_item changes.

  ## Examples

      iex> change_action_log_item(action_log_item)
      %Ecto.Changeset{data: %ActionLogItem{}}

  """
  def change_action_log_item(%ActionLogItem{} = action_log_item, attrs \\ %{}) do
    ActionLogItem.changeset(action_log_item, attrs)
  end
end
