defmodule DictionaryGame.Games.PlayerWordApproval do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_word_approvals" do
    field :approved, :boolean, default: false
    field :player_id, :id
    field :word_id, :id
    field :round_id, :id

    timestamps()
  end

  @doc false
  def changeset(player_word_approval, attrs) do
    player_word_approval
    |> cast(attrs, [:approved])
    |> validate_required([:approved])
  end
end
