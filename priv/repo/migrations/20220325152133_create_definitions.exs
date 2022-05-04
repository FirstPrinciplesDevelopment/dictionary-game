defmodule DictionaryGame.Repo.Migrations.CreateDefinitions do
  use Ecto.Migration

  def change do
    create table(:definitions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :definition, :string
      add :is_real, :boolean, default: false, null: false
      add :player_id, references(:players, on_delete: :nilify_all, type: :binary_id)
      add :word_id, references(:words, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:definitions, [:player_id])
    create index(:definitions, [:word_id])
    create unique_index(:definitions, [:player_id, :word_id, :is_real])
  end
end
