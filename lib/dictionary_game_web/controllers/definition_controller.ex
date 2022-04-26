defmodule DictionaryGameWeb.DefinitionController do
  use DictionaryGameWeb, :controller

  alias DictionaryGame.Dictionary
  alias DictionaryGame.Dictionary.Definition

  def index(conn, _params) do
    definitions = Dictionary.list_definitions()
    render(conn, "index.html", definitions: definitions)
  end

  def new(conn, _params) do
    changeset = Dictionary.change_definition(%Definition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"definition" => definition_params}) do
    case Dictionary.create_definition(definition_params) do
      {:ok, definition} ->
        conn
        |> put_flash(:info, "Definition created successfully.")
        |> redirect(to: Routes.definition_path(conn, :show, definition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    definition = Dictionary.get_definition!(id)
    render(conn, "show.html", definition: definition)
  end

  def edit(conn, %{"id" => id}) do
    definition = Dictionary.get_definition!(id)
    changeset = Dictionary.change_definition(definition)
    render(conn, "edit.html", definition: definition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "definition" => definition_params}) do
    definition = Dictionary.get_definition!(id)

    case Dictionary.update_definition(definition, definition_params) do
      {:ok, definition} ->
        conn
        |> put_flash(:info, "Definition updated successfully.")
        |> redirect(to: Routes.definition_path(conn, :show, definition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", definition: definition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    definition = Dictionary.get_definition!(id)
    {:ok, _definition} = Dictionary.delete_definition(definition)

    conn
    |> put_flash(:info, "Definition deleted successfully.")
    |> redirect(to: Routes.definition_path(conn, :index))
  end
end
