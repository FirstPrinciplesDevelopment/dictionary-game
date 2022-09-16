defmodule DictionaryGame.ActionLogsTest do
  use DictionaryGame.DataCase

  alias DictionaryGame.ActionLogs

  describe "action_log_items" do
    alias DictionaryGame.ActionLogs.ActionLogItem

    import DictionaryGame.ActionLogsFixtures

    @invalid_attrs %{color: nil, message: nil, type: nil, user_id: nil}

    test "list_action_log_items/0 returns all action_log_items" do
      action_log_item = action_log_item_fixture()
      assert ActionLogs.list_action_log_items() == [action_log_item]
    end

    test "get_action_log_item!/1 returns the action_log_item with given id" do
      action_log_item = action_log_item_fixture()
      assert ActionLogs.get_action_log_item!(action_log_item.id) == action_log_item
    end

    test "create_action_log_item/1 with valid data creates a action_log_item" do
      valid_attrs = %{color: "some color", message: "some message", type: "some type", user_id: "some user_id"}

      assert {:ok, %ActionLogItem{} = action_log_item} = ActionLogs.create_action_log_item(valid_attrs)
      assert action_log_item.color == "some color"
      assert action_log_item.message == "some message"
      assert action_log_item.type == "some type"
      assert action_log_item.user_id == "some user_id"
    end

    test "create_action_log_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ActionLogs.create_action_log_item(@invalid_attrs)
    end

    test "update_action_log_item/2 with valid data updates the action_log_item" do
      action_log_item = action_log_item_fixture()
      update_attrs = %{color: "some updated color", message: "some updated message", type: "some updated type", user_id: "some updated user_id"}

      assert {:ok, %ActionLogItem{} = action_log_item} = ActionLogs.update_action_log_item(action_log_item, update_attrs)
      assert action_log_item.color == "some updated color"
      assert action_log_item.message == "some updated message"
      assert action_log_item.type == "some updated type"
      assert action_log_item.user_id == "some updated user_id"
    end

    test "update_action_log_item/2 with invalid data returns error changeset" do
      action_log_item = action_log_item_fixture()
      assert {:error, %Ecto.Changeset{}} = ActionLogs.update_action_log_item(action_log_item, @invalid_attrs)
      assert action_log_item == ActionLogs.get_action_log_item!(action_log_item.id)
    end

    test "delete_action_log_item/1 deletes the action_log_item" do
      action_log_item = action_log_item_fixture()
      assert {:ok, %ActionLogItem{}} = ActionLogs.delete_action_log_item(action_log_item)
      assert_raise Ecto.NoResultsError, fn -> ActionLogs.get_action_log_item!(action_log_item.id) end
    end

    test "change_action_log_item/1 returns a action_log_item changeset" do
      action_log_item = action_log_item_fixture()
      assert %Ecto.Changeset{} = ActionLogs.change_action_log_item(action_log_item)
    end
  end
end
