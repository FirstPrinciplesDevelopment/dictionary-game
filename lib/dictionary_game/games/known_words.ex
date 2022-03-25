defmodule DictionaryGame.Games.KnownWords do
  use Ecto.Schema
  import Ecto.Changeset

  schema "known_words" do

    field :game_id, :id
    field :word_id, :id

    timestamps()
  end

  @doc false
  def changeset(known_words, attrs) do
    known_words
    |> cast(attrs, [])
    |> validate_required([])
  end
end
