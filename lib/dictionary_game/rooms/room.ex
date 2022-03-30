defmodule DictionaryGame.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :description, :string
    field :is_censored, :boolean, default: false
    field :is_public, :boolean, default: false
    field :name, :string

    has_many :players, DictionaryGame.Rooms.Player

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:description, :is_censored, :is_public, :name])
    |> validate_required([:is_censored, :is_public, :name])
    |> validate_length(:name, min: 3, max: 20)
    |> validate_length(:description, max: 100)
    |> unique_constraint(:name)
  end
end
