defmodule DictionaryGame.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :description, :string
      add :is_public, :boolean, default: false, null: false
      add :is_censored, :boolean, default: false, null: false
      add :name, :string

      timestamps()
    end

    create unique_index(:rooms, [:name])
  end
end
