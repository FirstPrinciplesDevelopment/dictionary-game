defmodule DictionaryGame.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :number_of_rounds, :integer
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:games, [:room_id])
  end
end
