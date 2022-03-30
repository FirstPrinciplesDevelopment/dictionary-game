defmodule DictionaryGame.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :score, :integer
      add :player_id, references(:players, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :delete_all)

      timestamps()
    end

    create index(:scores, [:player_id])
  end
end
