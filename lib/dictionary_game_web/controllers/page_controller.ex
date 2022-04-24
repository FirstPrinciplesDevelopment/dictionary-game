defmodule DictionaryGameWeb.PageController do
  use DictionaryGameWeb, :controller

  alias DictionaryGame.Dictionary
  alias DictionaryGame.Dictionary.{Definition, Word}

  def index(conn, _params) do
    if length(Dictionary.list_words()) == 0 do
      seed_database()
    end
    render(conn, "index.html")
  end

  defp seed_database do
    {:ok, word} =
      DictionaryGame.Repo.insert(%Word{
        word: "retroflexion",
        part_of_speech: "noun"
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
        part_of_speech: "adjective"
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
        part_of_speech: "noun"
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
        part_of_speech: "noun"
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
        part_of_speech: "noun"
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
        part_of_speech: "noun"
      })

    DictionaryGame.Repo.insert!(%Definition{
      word_id: word.id,
      definition: "Yellow No. 5.",
      is_real: true,
      player_id: nil
    })
  end
end
