defmodule DictionaryGame.Repo.Migrations.AlterGame do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :host_user_id, :string, null: false
    end
  end
end
