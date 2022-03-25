defmodule DictionaryGame.Games.PlayerDefinitionVotes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_definition_votes" do

    field :player_id, :id
    field :definition_id, :id
    field :round_id, :id

    timestamps()
  end

  @doc false
  def changeset(player_definition_votes, attrs) do
    player_definition_votes
    |> cast(attrs, [])
    |> validate_required([])
  end
end
