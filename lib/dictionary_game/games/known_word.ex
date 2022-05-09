defmodule DictionaryGame.Games.KnownWord do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "known_words" do
    # field :game_id, :binary_id
    # field :word_id, :binary_id

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
