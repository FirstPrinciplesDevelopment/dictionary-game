defmodule DictionaryGame.Repo.Migrations.CreateKnownWord do
  use Ecto.Migration

  def change do
    create table(:known_words) do
      add :game_id, references(:games, on_delete: :nothing)
      add :word_id, references(:integer, on_delete: :nothing)

      timestamps()
    end

    create index(:known_words, [:game_id])
    create index(:known_words, [:word_id])
  end
end
