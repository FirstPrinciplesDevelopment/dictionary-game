defmodule DictionaryGame.Repo.Migrations.CreatePlayerDefinitionVote do
  use Ecto.Migration

  def change do
    create table(:player_definition_votes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_id, references(:players, on_delete: :delete_all, type: :binary_id)
      add :definition_id, references(:definitions, on_delete: :delete_all, type: :binary_id)
      add :round_id, references(:rounds, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:player_definition_votes, [:player_id])
    create index(:player_definition_votes, [:definition_id])
    create index(:player_definition_votes, [:round_id])
    # Only allow one vote per player per round.
    create unique_index(:player_definition_votes, [:player_id, :round_id])
  end
end
