defmodule DictionaryGame.Repo do
  use Ecto.Repo,
    otp_app: :dictionary_game,
    adapter: Ecto.Adapters.Postgres
end
