defmodule DictionaryGameWeb.PageController do
  use DictionaryGameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
