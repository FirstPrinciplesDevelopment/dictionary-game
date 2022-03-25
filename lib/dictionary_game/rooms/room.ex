defmodule DictionaryGame.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :room_code, :string

    has_many :players, DictionaryGame.Rooms.Player

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_code])
    |> validate_required([:room_code])
    |> validate_length(:room_code, min: 3, max: 20)
    |> unique_constraint(:room_code)
  end
end
