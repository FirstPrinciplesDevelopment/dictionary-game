defmodule DictionaryGame.Games.PlayerDefinitionVote do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "player_definition_votes" do
    # field :player_id, :binary_id
    # field :definition_id, :binary_id
    # field :round_id, :binary_id

    belongs_to :player, DictionaryGame.Games.Player
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
