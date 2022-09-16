defmodule DictionaryGameWeb.ActionLogItemLiveTest do
  use DictionaryGameWeb.ConnCase

  import Phoenix.LiveViewTest
  import DictionaryGame.ActionLogsFixtures

  @create_attrs %{color: "some color", message: "some message", type: "some type", user_id: "some user_id"}
  @update_attrs %{color: "some updated color", message: "some updated message", type: "some updated type", user_id: "some updated user_id"}
  @invalid_attrs %{color: nil, message: nil, type: nil, user_id: nil}

  defp create_action_log_item(_) do
    action_log_item = action_log_item_fixture()
    %{action_log_item: action_log_item}
  end

  describe "Index" do
    setup [:create_action_log_item]

    test "lists all action_log_items", %{conn: conn, action_log_item: action_log_item} do
      {:ok, _index_live, html} = live(conn, Routes.action_log_item_index_path(conn, :index))

      assert html =~ "Listing Action log items"
      assert html =~ action_log_item.color
    end

    test "saves new action_log_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.action_log_item_index_path(conn, :index))

      assert index_live |> element("a", "New Action log item") |> render_click() =~
               "New Action log item"

      assert_patch(index_live, Routes.action_log_item_index_path(conn, :new))

      assert index_live
             |> form("#action_log_item-form", action_log_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#action_log_item-form", action_log_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.action_log_item_index_path(conn, :index))

      assert html =~ "Action log item created successfully"
      assert html =~ "some color"
    end

    test "updates action_log_item in listing", %{conn: conn, action_log_item: action_log_item} do
      {:ok, index_live, _html} = live(conn, Routes.action_log_item_index_path(conn, :index))

      assert index_live |> element("#action_log_item-#{action_log_item.id} a", "Edit") |> render_click() =~
               "Edit Action log item"

      assert_patch(index_live, Routes.action_log_item_index_path(conn, :edit, action_log_item))

      assert index_live
             |> form("#action_log_item-form", action_log_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#action_log_item-form", action_log_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.action_log_item_index_path(conn, :index))

      assert html =~ "Action log item updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes action_log_item in listing", %{conn: conn, action_log_item: action_log_item} do
      {:ok, index_live, _html} = live(conn, Routes.action_log_item_index_path(conn, :index))

      assert index_live |> element("#action_log_item-#{action_log_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#action_log_item-#{action_log_item.id}")
    end
  end

  describe "Show" do
    setup [:create_action_log_item]

    test "displays action_log_item", %{conn: conn, action_log_item: action_log_item} do
      {:ok, _show_live, html} = live(conn, Routes.action_log_item_show_path(conn, :show, action_log_item))

      assert html =~ "Show Action log item"
      assert html =~ action_log_item.color
    end

    test "updates action_log_item within modal", %{conn: conn, action_log_item: action_log_item} do
      {:ok, show_live, _html} = live(conn, Routes.action_log_item_show_path(conn, :show, action_log_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Action log item"

      assert_patch(show_live, Routes.action_log_item_show_path(conn, :edit, action_log_item))

      assert show_live
             |> form("#action_log_item-form", action_log_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#action_log_item-form", action_log_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.action_log_item_show_path(conn, :show, action_log_item))

      assert html =~ "Action log item updated successfully"
      assert html =~ "some updated color"
    end
  end
end
