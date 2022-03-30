defmodule DictionaryGame.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room_code, :string
      add :is_public, :boolean, default: false

      timestamps()
    end

    create unique_index(:rooms, [:room_code])
  end
end
