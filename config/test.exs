import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :argon2_elixir, t_cost: 1, m_cost: 8

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dictionary_game, DictionaryGame.Repo,
username: "postgres",
password: "postgres",
hostname: "localhost",
database: "dictionary_game_test#{System.get_env("MIX_TEST_PARTITION")}",
pool: Ecto.Adapters.SQL.Sandbox,
pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dictionary_game, DictionaryGameWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "eQtn1x3m3ymRoTp5y53vZ8T4RFoB+jbHY1zH8d7nx/d17N2xjCHL6OrWSQ3Bws8b",
  server: false

# In test we don't send emails.
config :dictionary_game, DictionaryGame.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
