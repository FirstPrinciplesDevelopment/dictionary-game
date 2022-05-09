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
alias DictionaryGame.Dictionary.{Definition, Word}

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "retroflexion",
    part_of_speech: "noun",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition: "a bending backward.",
  is_real: true,
  player_id: nil
})

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "polychromatic",
    part_of_speech: "adjective",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition: "having or exhibiting a variety of colors.",
  is_real: true,
  player_id: nil
})

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "gremmie",
    part_of_speech: "noun",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition: "a novice surfer or one with poor form.",
  is_real: true,
  player_id: nil
})

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "enteron",
    part_of_speech: "noun",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition: "the alimentary canal; the digestive tract.",
  is_real: true,
  player_id: nil
})

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "tensegrity",
    part_of_speech: "noun",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition:
    "the property of skeleton structures that employ continuous tension members and discontinuous compression members in such a way that each member operates with the maximum efficiency and economy.",
  is_real: true,
  player_id: nil
})

{:ok, word} =
  DictionaryGame.Repo.insert(%Word{
    word: "tartrazine",
    part_of_speech: "noun",
    is_real: true,
    player_id: nil
  })

DictionaryGame.Repo.insert!(%Definition{
  word_id: word.id,
  definition: "Yellow No. 5.",
  is_real: true,
  player_id: nil
})
