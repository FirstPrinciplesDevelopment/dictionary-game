defmodule DictionaryGame.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :word, :string
      add :part_of_speech, :string
      add :is_real, :boolean, default: false, null: false
      add :player_id, references(:players, on_delete: :nilify_all, type: :binary_id)
    end

    create index(:words, [:player_id])
    create unique_index(:words, [:word])
  end
end
