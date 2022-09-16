defmodule DictionaryGame.Repo.Migrations.CreateActionLogItems do
  use Ecto.Migration

  def change do
    create table(:action_log_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :string
      add :message, :string, null: false
      add :color, :string
      add :type, :string

      timestamps()
    end
  end
end
