# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DictionaryGame.Repo.insert!(%DictionaryGame.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias DictionaryGame.Game.Definition

DictionaryGame.Repo.insert!(%Definition{
  word: "retroflexion",
  part_of_speech: "noun",
  definition: "a bending backward.",
  is_real: true,
  player: nil
})

DictionaryGame.Repo.insert!(%Definition{
  word: "polychromatic",
  part_of_speech: "adjective",
  definition: "having or exhibiting a variety of colors.",
  is_real: true,
  player: nil
})
