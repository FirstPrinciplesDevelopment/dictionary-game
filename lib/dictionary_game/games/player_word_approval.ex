defmodule DictionaryGame.Games.PlayerWordApproval do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_word_approvals" do
    # field :player_id, :id
    # field :word_id, :id
    # field :round_id, :id

    belongs_to :player, DictionaryGame.Rooms.Player
    belongs_to :word, DictionaryGame.Dictionary.Word
    belongs_to :round, DictionaryGame.Games.Round

    timestamps()
  end

  @doc false
  def changeset(player_word_approval, _attrs) do
    player_word_approval
    |> unique_constraint([:player_id, :word_id])
  end
end
