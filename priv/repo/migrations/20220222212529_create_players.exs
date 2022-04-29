defmodule DictionaryGame.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false
      add :user_id, :string, null: false
      add :is_host, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :score, :integer, default: 0, null: false
      add :display_score, :integer, default: 0, null: false

      timestamps()
    end

    create index(:players, [:game_id])
    # player names inside a game must be unique
    create unique_index(:players, [:name, :game_id])
  end
end
