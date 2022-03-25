defmodule DictionaryGame.Dictionary.Definition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "definitions" do
    field :definition, :string
    field :is_real, :boolean, default: false
    field :player_id, :id
    field :word_id, :id

    timestamps()
  end

  @doc false
  def changeset(definition, attrs) do
    definition
    |> cast(attrs, [:definition, :is_real])
    |> validate_required([:definition, :is_real])
  end
end
