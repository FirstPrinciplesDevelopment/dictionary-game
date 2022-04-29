defmodule DictionaryGame.Games.PlayedWord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "played_words" do
    # field :game_id, :id
    # field :word_id, :id

    belongs_to :game, DictionaryGame.Games.Game
    belongs_to :word, DictionaryGame.Dictionary.Word

    timestamps()
  end

  @doc false
  def changeset(played_word, attrs) do
    played_word
    |> cast(attrs, [])
    |> validate_required([])
  end
end
