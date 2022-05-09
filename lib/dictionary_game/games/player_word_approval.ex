defmodule DictionaryGame.Games.PlayerWordApproval do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "player_word_approvals" do
    # field :player_id, :binary_id
    # field :word_id, :binary_id
    # field :round_id, :binary_id

    belongs_to :player, DictionaryGame.Games.Player
    belongs_to :word, DictionaryGame.Dictionary.Word
    belongs_to :round, DictionaryGame.Games.Round

    timestamps()
  end

  @doc false
  def changeset(player_word_approval, attrs) do
    player_word_approval
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint([:player_id, :word_id])
  end
end
