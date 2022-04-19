defmodule DictionaryGame.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false
      add :user_id, :string, null: false
      add :is_host, :boolean, default: false, null: false
      add :is_in_game, :boolean, default: false, null: false
      add :room_id, references(:rooms, on_delete: :delete_all), null: false
      add :score, :integer, default: 0, null: false
      add :display_score, :integer, default: 0, null: false

      timestamps()
    end

    create index(:players, [:room_id])
    # player names inside a room must be unique
    create unique_index(:players, [:name, :room_id])
  end
end
