defmodule DictionaryGame.Games.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :score, :integer, default: 0
    field :player_id, :id
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
