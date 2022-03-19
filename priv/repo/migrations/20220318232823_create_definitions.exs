defmodule DictionaryGame.Repo.Migrations.CreateDefinitions do
  use Ecto.Migration

  def change do
    create table(:definitions) do
      add :word, :string
      add :part_of_speech, :string
      add :definition, :string
      add :is_real, :boolean
      add :player_id, references(:players), null: true

      timestamps()
    end

    create unique_index(:definitions, [:word])
  end
end
