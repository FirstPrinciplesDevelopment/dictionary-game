defmodule DictionaryGame.Repo.Migrations.CreatePlayedWord do
  use Ecto.Migration

  def change do
    create table(:played_words) do
      add :game_id, references(:games, on_delete: :nothing)
      add :word_id, references(:integer, on_delete: :nothing)

      timestamps()
    end

    create index(:played_words, [:game_id])
    create index(:played_words, [:word_id])
  end
end
