defmodule DictionaryGame.Games.PlayerDefinitionVote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_definition_votes" do
    # field :player_id, :id
    # field :definition_id, :id
    # field :round_id, :id

    belongs_to :player, DictionaryGame.Rooms.Player
    belongs_to :definition, DictionaryGame.Dictionary.Definition
    belongs_to :round, DictionaryGame.Games.Round

    timestamps()
  end

  @doc false
  def changeset(player_definition_votes, attrs) do
    player_definition_votes
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint([:player_id, :round])
  end
end
