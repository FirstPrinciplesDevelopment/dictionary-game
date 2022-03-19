defmodule DictionaryGameWeb.DefinitionLiveTest do
  use DictionaryGameWeb.ConnCase

  import Phoenix.LiveViewTest
  import DictionaryGame.GameFixtures

  @create_attrs %{definition: "some definition", part_of_speech: "some part_of_speech", word: "some word"}
  @update_attrs %{definition: "some updated definition", part_of_speech: "some updated part_of_speech", word: "some updated word"}
  @invalid_attrs %{definition: nil, part_of_speech: nil, word: nil}

  defp create_definition(_) do
    definition = definition_fixture()
    %{definition: definition}
  end

  describe "Index" do
    setup [:create_definition]

    test "lists all definitions", %{conn: conn, definition: definition} do
      {:ok, _index_live, html} = live(conn, Routes.definition_index_path(conn, :index))

      assert html =~ "Listing Definitions"
      assert html =~ definition.definition
    end

    test "saves new definition", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.definition_index_path(conn, :index))

      assert index_live |> element("a", "New Definition") |> render_click() =~
               "New Definition"

      assert_patch(index_live, Routes.definition_index_path(conn, :new))

      assert index_live
             |> form("#definition-form", definition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#definition-form", definition: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.definition_index_path(conn, :index))

      assert html =~ "Definition created successfully"
      assert html =~ "some definition"
    end

    test "updates definition in listing", %{conn: conn, definition: definition} do
      {:ok, index_live, _html} = live(conn, Routes.definition_index_path(conn, :index))

      assert index_live |> element("#definition-#{definition.id} a", "Edit") |> render_click() =~
               "Edit Definition"

      assert_patch(index_live, Routes.definition_index_path(conn, :edit, definition))

      assert index_live
             |> form("#definition-form", definition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#definition-form", definition: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.definition_index_path(conn, :index))

      assert html =~ "Definition updated successfully"
      assert html =~ "some updated definition"
    end

    test "deletes definition in listing", %{conn: conn, definition: definition} do
      {:ok, index_live, _html} = live(conn, Routes.definition_index_path(conn, :index))

      assert index_live |> element("#definition-#{definition.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#definition-#{definition.id}")
    end
  end

  describe "Show" do
    setup [:create_definition]

    test "displays definition", %{conn: conn, definition: definition} do
      {:ok, _show_live, html} = live(conn, Routes.definition_show_path(conn, :show, definition))

      assert html =~ "Show Definition"
      assert html =~ definition.definition
    end

    test "updates definition within modal", %{conn: conn, definition: definition} do
      {:ok, show_live, _html} = live(conn, Routes.definition_show_path(conn, :show, definition))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Definition"

      assert_patch(show_live, Routes.definition_show_path(conn, :edit, definition))

      assert show_live
             |> form("#definition-form", definition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#definition-form", definition: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.definition_show_path(conn, :show, definition))

      assert html =~ "Definition updated successfully"
      assert html =~ "some updated definition"
    end
  end
end
