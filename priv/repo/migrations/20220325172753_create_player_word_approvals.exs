defmodule DictionaryGame.Repo.Migrations.CreatePlayerWordApprovals do
  use Ecto.Migration

  def change do
    create table(:player_word_approvals) do
      add :approved, :boolean, default: false, null: false
      add :player_id, references(:players, on_delete: :delete_all)
      add :word_id, references(:words, on_delete: :delete_all)
      add :round_id, references(:rounds, on_delete: :delete_all)

      timestamps()
    end

    create index(:player_word_approvals, [:player_id])
    create index(:player_word_approvals, [:word_id])
    create index(:player_word_approvals, [:round_id])
    # Only one record per word per player is needed.
    create unique_index(:player_word_approvals, [:player_id, :word_id])

  end
end
