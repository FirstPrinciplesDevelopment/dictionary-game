defmodule DictionaryGame.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :number_of_rounds, :integer, default: 3
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:number_of_rounds])
    |> validate_required([:room_id])
  end
end
