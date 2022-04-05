defmodule DictionaryGame.Games.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :score, :integer, default: 0

    field :game_id, :id
    field :player_id, :id

    # belongs_to :player, DictionaryGame.Rooms.Player
    # belongs_to :game, DictionaryGame.Games.Game

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:score, :game_id, :player_id])
    |> validate_required([:score, :game_id, :player_id])
    |> unique_constraint([:game_id, :player_id])
  end
end
