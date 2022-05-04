defmodule DictionaryGame.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "games" do
    field :number_of_rounds, :integer, default: 3
    field :description, :string
    field :is_censored, :boolean, default: false
    field :is_public, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:number_of_rounds, :description, :is_censored, :is_public, :name])
    |> validate_required([:is_censored, :is_public, :name])
    |> validate_length(:name, min: 3, max: 20)
    |> validate_length(:description, max: 50)
    |> unique_constraint(:name)
  end
end
