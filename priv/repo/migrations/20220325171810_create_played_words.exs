defmodule DictionaryGame.Repo.Migrations.CreatePlayedWord do
  use Ecto.Migration

  def change do
    create table(:played_words, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)
      add :word_id, references(:words, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:played_words, [:game_id])
    create index(:played_words, [:word_id])
  end
end
