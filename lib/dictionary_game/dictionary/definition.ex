defmodule DictionaryGame.Dictionary.Definition do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "definitions" do
    field :definition, :string
    field :is_real, :boolean, default: false
    # field :player_id, :binary_id
    # field :word_id, :binary_id

    belongs_to :player, DictionaryGame.Games.Player
    belongs_to :word, DictionaryGame.Dictionary.Word
  end

  @doc false
  def changeset(definition, attrs) do
    definition
    |> cast(attrs, [:definition, :is_real])
    |> validate_required([:definition, :is_real])
    |> unique_constraint([:player_id, :word_id, :is_real])
    |> unique_constraint(:definition)
  end
end
