defmodule DictionaryGame.Repo.Migrations.CreatePlayerDefinitionVotes do
  use Ecto.Migration

  def change do
    create table(:player_definition_votes) do
      add :player_id, references(:players, on_delete: :nothing)
      add :definition_id, references(:definitions, on_delete: :nothing)
      add :round_id, references(:rounds, on_delete: :nothing)

      timestamps()
    end

    create index(:player_definition_votes, [:player_id])
    create index(:player_definition_votes, [:definition_id])
    create index(:player_definition_votes, [:round_id])
  end
end
