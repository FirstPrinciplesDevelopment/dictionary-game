defmodule DictionaryGameWeb.WordController do
  use DictionaryGameWeb, :controller
  import CSV

  alias DictionaryGame.Dictionary
  alias DictionaryGame.Dictionary.Word

  def index(conn, _params) do
    words = Dictionary.list_words()
    render(conn, "index.html", words: words)
  end

  def new(conn, _params) do
    changeset = Dictionary.change_word(%Word{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"word" => word_params}) do
    case Dictionary.create_real_word_and_definition(word_params) do
      {:ok, word} ->
        conn
        |> put_flash(:info, "Word created successfully.")
        |> redirect(to: Routes.word_path(conn, :show, word))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    word = Dictionary.get_word!(id)
    definition = Dictionary.get_real_definition!(id)
    render(conn, "show.html", word: word, definition: definition)
  end

  def edit(conn, %{"id" => id}) do
    word = Dictionary.get_word!(id)
    changeset = Dictionary.change_word(word)
    render(conn, "edit.html", word: word, changeset: changeset)
  end

  def update(conn, %{"id" => id, "word" => word_params}) do
    word = Dictionary.get_word!(id)

    case Dictionary.update_word(word, word_params) do
      {:ok, word} ->
        conn
        |> put_flash(:info, "Word updated successfully.")
        |> redirect(to: Routes.word_path(conn, :show, word))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", word: word, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    word = Dictionary.get_word!(id)
    {:ok, _word} = Dictionary.delete_word(word)

    conn
    |> put_flash(:info, "Word deleted successfully.")
    |> redirect(to: Routes.word_path(conn, :index))
  end

  def import(conn, %{"words" => words_file}) do
    words_file.path
    |> File.stream!()
    |> CSV.decode()
    |> Enum.map(fn {:ok, word} ->
      %{
        "word" => Enum.at(word, 0),
        "definition" => Enum.at(word, 1),
        "part_of_speech" => Enum.at(word, 2)
      }
      |> Dictionary.create_real_word_and_definition()
    end)
    |> Enum.filter(fn
      {:error, _changeset} -> true
      _ -> false
    end)
    |> case do
      [] ->
        conn
        |> put_flash(:info, "Imported")
        |> redirect(to: Routes.word_path(conn, :index))

      errors ->
        conn
        |> put_flash(:error, errors)
        |> render("import.html")
    end
  end

  def import(conn, _params) do
    changeset = %{}
    render(conn, "import.html", changeset: changeset)
  end
end
