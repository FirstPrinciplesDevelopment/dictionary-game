defmodule DictionaryGame.Games.KnownWord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "known_words" do
    # field :game_id, :id
    # field :word_id, :id

    # TODO: consider changing game to room and adding a fk to player, to make sure a player doesn't get a known word again.
    belongs_to :game, DictionaryGame.Games.Game
    belongs_to :word, DictionaryGame.Dictionary.Word

    timestamps()
  end

  @doc false
  def changeset(known_words, attrs) do
    known_words
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint([:game_id, :word_id])
  end
end