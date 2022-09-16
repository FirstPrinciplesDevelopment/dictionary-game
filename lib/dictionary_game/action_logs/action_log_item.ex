defmodule DictionaryGame.ActionLogs.ActionLogItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "action_log_items" do
    field :color, :string
    field :message, :string
    field :type, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(action_log_item, attrs) do
    action_log_item
    |> cast(attrs, [:user_id, :message, :color, :type])
    |> validate_required([:user_id, :message, :color, :type])
  end
end
