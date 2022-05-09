defmodule DictionaryGame.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :round_number, :integer
      add :is_approved, :boolean, default: false, null: false
      add :are_definitions_submitted, :boolean, default: false, null: false
      add :are_votes_submitted, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)
      add :word_id, references(:words, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end

    create index(:rounds, [:game_id])
    create index(:rounds, [:word_id])
  end
end
