defmodule DictionaryGame.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :round_number, :integer
      add :game_id, references(:games, on_delete: :nothing)
      add :word_id, references(:words, on_delete: :nothing)

      timestamps()
    end

    create index(:rounds, [:game_id])
    create index(:rounds, [:word_id])
  end
end
