defmodule DictionaryGame.Repo.Migrations.CreatePlayedWord do
  use Ecto.Migration

  def change do
    create table(:played_words) do
      add :game_id, references(:games, on_delete: :delete_all)
      add :word_id, references(:words, on_delete: :delete_all)

      timestamps()
    end

    create index(:played_words, [:game_id])
    create index(:played_words, [:word_id])
  end
end
