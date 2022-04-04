defmodule DictionaryGame.Repo.Migrations.CreateDefinitions do
  use Ecto.Migration

  def change do
    create table(:definitions) do
      add :definition, :string
      add :is_real, :boolean, default: false, null: false
      add :player_id, references(:players, on_delete: :nilify_all)
      add :word_id, references(:words, on_delete: :delete_all)

      timestamps()
    end

    create index(:definitions, [:player_id])
    create index(:definitions, [:word_id])
    create unique_index(:definitions, [:player_id, :word_id, :is_real])
  end
end
