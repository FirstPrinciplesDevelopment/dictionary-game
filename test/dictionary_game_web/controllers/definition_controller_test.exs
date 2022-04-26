defmodule DictionaryGameWeb.DefinitionControllerTest do
  use DictionaryGameWeb.ConnCase

  import DictionaryGame.DictionaryFixtures

  @create_attrs %{definition: "some definition", is_real: true}
  @update_attrs %{definition: "some updated definition", is_real: false}
  @invalid_attrs %{definition: nil, is_real: nil}

  describe "index" do
    test "lists all definitions", %{conn: conn} do
      conn = get(conn, Routes.definition_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Definitions"
    end
  end

  describe "new definition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.definition_path(conn, :new))
      assert html_response(conn, 200) =~ "New Definition"
    end
  end

  describe "create definition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.definition_path(conn, :create), definition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.definition_path(conn, :show, id)

      conn = get(conn, Routes.definition_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Definition"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.definition_path(conn, :create), definition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Definition"
    end
  end

  describe "edit definition" do
    setup [:create_definition]

    test "renders form for editing chosen definition", %{conn: conn, definition: definition} do
      conn = get(conn, Routes.definition_path(conn, :edit, definition))
      assert html_response(conn, 200) =~ "Edit Definition"
    end
  end

  describe "update definition" do
    setup [:create_definition]

    test "redirects when data is valid", %{conn: conn, definition: definition} do
      conn = put(conn, Routes.definition_path(conn, :update, definition), definition: @update_attrs)
      assert redirected_to(conn) == Routes.definition_path(conn, :show, definition)

      conn = get(conn, Routes.definition_path(conn, :show, definition))
      assert html_response(conn, 200) =~ "some updated definition"
    end

    test "renders errors when data is invalid", %{conn: conn, definition: definition} do
      conn = put(conn, Routes.definition_path(conn, :update, definition), definition: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Definition"
    end
  end

  describe "delete definition" do
    setup [:create_definition]

    test "deletes chosen definition", %{conn: conn, definition: definition} do
      conn = delete(conn, Routes.definition_path(conn, :delete, definition))
      assert redirected_to(conn) == Routes.definition_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.definition_path(conn, :show, definition))
      end
    end
  end

  defp create_definition(_) do
    definition = definition_fixture()
    %{definition: definition}
  end
end
