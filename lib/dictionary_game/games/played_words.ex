defmodule DictionaryGame.Games.PlayedWord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_words" do
    # TODO: consider changing game to room and adding a fk to player, to make sure a player doesn't get a known word again.
    field :game_id, :id
    field :word_id, :id

    timestamps()
  end

  @doc false
  def changeset(played_words, attrs) do
    played_words
    |> cast(attrs, [])
    |> validate_required([])
  end
end
