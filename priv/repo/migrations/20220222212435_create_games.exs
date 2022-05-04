defmodule DictionaryGame.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :number_of_rounds, :integer, default: 3
      add :description, :string
      add :is_public, :boolean, default: false, null: false
      add :is_censored, :boolean, default: false, null: false
      add :name, :string

      timestamps()
    end

    create unique_index(:games, [:name])
  end
end
