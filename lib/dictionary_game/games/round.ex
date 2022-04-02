defmodule DictionaryGame.Games.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :round_number, :integer
    # field :word_id, :id

    # Read about :on_replace https://hexdocs.pm/ecto/Ecto.Changeset.html#module-the-on_replace-option
    belongs_to :word, DictionaryGame.Dictionary.Word, on_replace: :nilify

    belongs_to :game, DictionaryGame.Games.Game

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:round_number])
    |> validate_required([:round_number])
  end
end
