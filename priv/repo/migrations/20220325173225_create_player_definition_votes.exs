defmodule DictionaryGame.Repo.Migrations.CreatePlayerDefinitionVote do
  use Ecto.Migration

  def change do
    create table(:player_definition_votes) do
      add :player_id, references(:players, on_delete: :delete_all)
      add :definition_id, references(:definitions, on_delete: :delete_all)
      add :round_id, references(:rounds, on_delete: :delete_all)

      timestamps()
    end

    create index(:player_definition_votes, [:player_id])
    create index(:player_definition_votes, [:definition_id])
    create index(:player_definition_votes, [:round_id])
    # Only allow one vote per player per round.
    create unique_index(:player_definition_votes, [:player_id, :round_id])
  end
end
