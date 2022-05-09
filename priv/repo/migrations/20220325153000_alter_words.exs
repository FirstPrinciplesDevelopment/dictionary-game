defmodule DictionaryGame.Repo.Migrations.AlterWords do
  use Ecto.Migration

  def change do
    alter table(:words) do
      add :definition_id, references(:definitions, on_delete: :delete_all, type: :binary_id)
    end

    create index(:words, [:definition_id])
    create unique_index(:words, [:player_id, :definition_id, :is_real])
  end
end
