defmodule DictionaryGame.Dictionary.Word do
  use Ecto.Schema
  import Ecto.Changeset

  schema "words" do
    field :part_of_speech, :string
    field :word, :string

    has_many :definitions, DictionaryGame.Dictionary.Definition

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:word, :part_of_speech])
    |> validate_required([:word, :part_of_speech])
    |> unique_constraint(:word)
  end
end
