defmodule DictionaryGame.Games.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :round_number, :integer
    field :game_id, :id
    field :word_id, :id

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:round_number])
    |> validate_required([:round_number])
  end
end
