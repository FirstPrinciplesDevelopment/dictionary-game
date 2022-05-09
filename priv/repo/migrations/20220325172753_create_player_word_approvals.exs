defmodule DictionaryGame.Repo.Migrations.CreatePlayerWordApprovals do
  use Ecto.Migration

  def change do
    create table(:player_word_approvals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_id, references(:players, on_delete: :delete_all, type: :binary_id)
      add :word_id, references(:words, on_delete: :delete_all, type: :binary_id)
      add :round_id, references(:rounds, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:player_word_approvals, [:player_id])
    create index(:player_word_approvals, [:word_id])
    create index(:player_word_approvals, [:round_id])
    # Only one record per word per player is needed.
    create unique_index(:player_word_approvals, [:player_id, :word_id])
  end
end
