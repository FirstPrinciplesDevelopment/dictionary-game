defmodule DictionaryGame.Game.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :room_code, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_code])
    |> validate_required([:room_code])
    |> unique_constraint(:room_code)
  end
end
