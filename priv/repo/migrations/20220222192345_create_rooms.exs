defmodule DictionaryGame.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room_code, :string

      timestamps()
    end

    create unique_index(:rooms, [:room_code])
  end
end
