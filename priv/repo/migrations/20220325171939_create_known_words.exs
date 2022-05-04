defmodule DictionaryGame.Repo.Migrations.CreateKnownWord do
  use Ecto.Migration

  def change do
    create table(:known_words, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)
      add :word_id, references(:words, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:known_words, [:game_id])
    create index(:known_words, [:word_id])
    # Only one known_words record per game per word is needed.
    create unique_index(:known_words, [:game_id, :word_id])
  end
end
