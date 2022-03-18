defmodule DictionaryGame.UserPlug do
  import Plug.Conn

  def init(options) do
    options
  end

  # This clause is used when user_id cookie is already set.
  def call(%Plug.Conn{cookies: %{"user_id" => user_id}} = conn, _opts) do
    conn
    |> put_session(:user_id, user_id)
  end

  # This clause is used when user_id cookie is not set.
  def call(conn, _opts) do
    uuid = UUID.uuid4()

    conn
    |> put_resp_cookie("user_id", uuid)
    |> put_session(:user_id, uuid)
  end
end
