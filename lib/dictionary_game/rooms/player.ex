defmodule DictionaryGame.Rooms.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :is_host, :boolean, default: false
    field :name, :string
    field :user_id, :string

    # replaced by belongs_to call below
    # field :room_id, :id

    belongs_to :room, DictionaryGame.Rooms.Room

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :is_host])
    |> validate_required([:name, :is_host, :room_id, :user_id])
  end
end