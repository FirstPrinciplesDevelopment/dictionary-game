defmodule DictionaryGame.Rooms.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :is_host, :boolean, default: false
    field :name, :string
    field :user_id, :string
    field :is_in_game, :boolean, default: false
    field :score, :integer, default: 0
    field :display_score, :integer, default: 0

    # replaced by belongs_to call below
    # field :room_id, :id
    belongs_to :room, DictionaryGame.Rooms.Room

    has_one :score, DictionaryGame.Games.Score

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :is_host])
    |> validate_required([:name, :is_host, :room_id, :user_id])
    |> validate_length(:name, min: 3, max: 12)
    |> unique_constraint([:name, :room_id])
  end
end
