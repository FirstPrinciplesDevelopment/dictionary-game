defmodule DictionaryGame.Repo.Migrations.CreateDefinitions do
  use Ecto.Migration

  def change do
    create table(:definitions) do
      add :definition, :string
      add :is_real, :boolean, default: false, null: false
      add :player_id, references(:players, on_delete: :nothing)
      add :word_id, references(:words, on_delete: :nothing)

      timestamps()
    end

    create index(:definitions, [:player_id])
    create index(:definitions, [:word_id])
  end
end
