defmodule DictionaryGame.Dictionary.Word do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "words" do
    field :part_of_speech, :string
    field :word, :string
    field :is_real, :boolean, default: false
    field :definition_id, :binary_id

    belongs_to :player, DictionaryGame.Games.Player
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:word, :part_of_speech, :is_real])
    |> validate_required([:word, :part_of_speech, :is_real])
    |> unique_constraint([:player_id, :definition_id, :is_real])
    |> unique_constraint(:word)
  end
end
