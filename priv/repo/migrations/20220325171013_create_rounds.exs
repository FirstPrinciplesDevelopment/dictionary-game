defmodule DictionaryGame.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :round_number, :integer
      add :is_approved, :boolean, default: false, null: false
      add :are_definitions_submitted, :boolean, default: false, null: false
      add :are_votes_submitted, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :delete_all)
      add :word_id, references(:words, on_delete: :nilify_all)

      timestamps()
    end

    create index(:rounds, [:game_id])
    create index(:rounds, [:word_id])
  end
end
