defmodule DictionaryGame.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :user_id, :string, null: false
      add :is_host, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false
      add :score, :integer, default: 0, null: false
      add :display_score, :integer, default: 0, null: false

      timestamps()
    end

    create index(:players, [:game_id])
    # Player names inside a game must be unique.
    create unique_index(:players, [:name, :game_id])
  end
end
