defmodule DictionaryGame.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :word, :string
      add :part_of_speech, :string

      timestamps()
    end

    create unique_index(:words, [:word])
  end
end
