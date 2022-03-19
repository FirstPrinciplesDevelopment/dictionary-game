defmodule DictionaryGame.Game.Definition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "definitions" do
    field :definition, :string
    field :part_of_speech, :string
    field :word, :string

    # Denotes whether the definition is real or user created.
    field :is_real, :boolean

    # The player who created the definition, will be null for a real definition.
    belongs_to :player, DictionaryGame.Game.Player

    timestamps()
  end

  @doc false
  def changeset(definition, attrs) do
    definition
    |> cast(attrs, [:word, :part_of_speech, :definition])
    |> validate_required([:word, :part_of_speech, :definition])
    |> unique_constraint(:word)
  end
end
