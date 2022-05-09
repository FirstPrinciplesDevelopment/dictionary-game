defmodule DictionaryGame.Games.PlayedWord do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "played_words" do
    # field :game_id, :binary_id
    # field :word_id, :binary_id

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
