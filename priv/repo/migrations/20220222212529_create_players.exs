defmodule DictionaryGame.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :is_host, :boolean, default: false, null: false
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:players, [:room_id])
  end
end
