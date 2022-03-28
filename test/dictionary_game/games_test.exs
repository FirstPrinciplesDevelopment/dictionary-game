defmodule DictionaryGame.GamesTest do
  use DictionaryGame.DataCase

  alias DictionaryGame.Games

  describe "games" do
    alias DictionaryGame.Games.Game

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{number_of_rounds: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{number_of_rounds: 42}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.number_of_rounds == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{number_of_rounds: 43}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.number_of_rounds == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "rounds" do
    alias DictionaryGame.Games.Round

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{round_number: nil}

    test "list_rounds/0 returns all rounds" do
      round = round_fixture()
      assert Games.list_rounds() == [round]
    end

    test "get_round!/1 returns the round with given id" do
      round = round_fixture()
      assert Games.get_round!(round.id) == round
    end

    test "create_round/1 with valid data creates a round" do
      valid_attrs = %{round_number: 42}

      assert {:ok, %Round{} = round} = Games.create_round(valid_attrs)
      assert round.round_number == 42
    end

    test "create_round/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_round(@invalid_attrs)
    end

    test "update_round/2 with valid data updates the round" do
      round = round_fixture()
      update_attrs = %{round_number: 43}

      assert {:ok, %Round{} = round} = Games.update_round(round, update_attrs)
      assert round.round_number == 43
    end

    test "update_round/2 with invalid data returns error changeset" do
      round = round_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_round(round, @invalid_attrs)
      assert round == Games.get_round!(round.id)
    end

    test "delete_round/1 deletes the round" do
      round = round_fixture()
      assert {:ok, %Round{}} = Games.delete_round(round)
      assert_raise Ecto.NoResultsError, fn -> Games.get_round!(round.id) end
    end

    test "change_round/1 returns a round changeset" do
      round = round_fixture()
      assert %Ecto.Changeset{} = Games.change_round(round)
    end
  end

  describe "scores" do
    alias DictionaryGame.Games.Score

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{score: nil}

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Games.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Games.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      valid_attrs = %{score: 42}

      assert {:ok, %Score{} = score} = Games.create_score(valid_attrs)
      assert score.score == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      update_attrs = %{score: 43}

      assert {:ok, %Score{} = score} = Games.update_score(score, update_attrs)
      assert score.score == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_score(score, @invalid_attrs)
      assert score == Games.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Games.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Games.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Games.change_score(score)
    end
  end

  describe "played_words" do
    alias DictionaryGame.Games.PlayedWord

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{}

    test "list_played_words/0 returns all played_words" do
      played_words = played_words_fixture()
      assert Games.list_played_words() == [played_words]
    end

    test "get_played_words!/1 returns the played_words with given id" do
      played_words = played_words_fixture()
      assert Games.get_played_words!(played_words.id) == played_words
    end

    test "create_played_words/1 with valid data creates a played_words" do
      valid_attrs = %{}

      assert {:ok, %PlayedWord{} = played_words} = Games.create_played_words(valid_attrs)
    end

    test "create_played_words/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_played_words(@invalid_attrs)
    end

    test "update_played_words/2 with valid data updates the played_words" do
      played_words = played_words_fixture()
      update_attrs = %{}

      assert {:ok, %PlayedWord{} = played_words} =
               Games.update_played_words(played_words, update_attrs)
    end

    test "update_played_words/2 with invalid data returns error changeset" do
      played_words = played_words_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_played_words(played_words, @invalid_attrs)
      assert played_words == Games.get_played_words!(played_words.id)
    end

    test "delete_played_words/1 deletes the played_words" do
      played_words = played_words_fixture()
      assert {:ok, %PlayedWord{}} = Games.delete_played_words(played_words)
      assert_raise Ecto.NoResultsError, fn -> Games.get_played_words!(played_words.id) end
    end

    test "change_played_words/1 returns a played_words changeset" do
      played_words = played_words_fixture()
      assert %Ecto.Changeset{} = Games.change_played_words(played_words)
    end
  end

  describe "known_words" do
    alias DictionaryGame.Games.KnownWord

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{}

    test "list_known_words/0 returns all known_words" do
      known_words = known_words_fixture()
      assert Games.list_known_words() == [known_words]
    end

    test "get_known_words!/1 returns the known_words with given id" do
      known_words = known_words_fixture()
      assert Games.get_known_words!(known_words.id) == known_words
    end

    test "create_known_words/1 with valid data creates a known_words" do
      valid_attrs = %{}

      assert {:ok, %KnownWord{} = known_words} = Games.create_known_words(valid_attrs)
    end

    test "create_known_words/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_known_words(@invalid_attrs)
    end

    test "update_known_words/2 with valid data updates the known_words" do
      known_words = known_words_fixture()
      update_attrs = %{}

      assert {:ok, %KnownWord{} = known_words} =
               Games.update_known_words(known_words, update_attrs)
    end

    test "update_known_words/2 with invalid data returns error changeset" do
      known_words = known_words_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_known_words(known_words, @invalid_attrs)
      assert known_words == Games.get_known_words!(known_words.id)
    end

    test "delete_known_words/1 deletes the known_words" do
      known_words = known_words_fixture()
      assert {:ok, %KnownWord{}} = Games.delete_known_words(known_words)
      assert_raise Ecto.NoResultsError, fn -> Games.get_known_words!(known_words.id) end
    end

    test "change_known_words/1 returns a known_words changeset" do
      known_words = known_words_fixture()
      assert %Ecto.Changeset{} = Games.change_known_words(known_words)
    end
  end

  describe "player_word_approvals" do
    alias DictionaryGame.Games.PlayerWordApproval

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{approved: nil}

    test "list_player_word_approvals/0 returns all player_word_approvals" do
      player_word_approval = player_word_approval_fixture()
      assert Games.list_player_word_approvals() == [player_word_approval]
    end

    test "get_player_word_approval!/1 returns the player_word_approval with given id" do
      player_word_approval = player_word_approval_fixture()
      assert Games.get_player_word_approval!(player_word_approval.id) == player_word_approval
    end

    test "create_player_word_approval/1 with valid data creates a player_word_approval" do
      valid_attrs = %{approved: true}

      assert {:ok, %PlayerWordApproval{} = player_word_approval} =
               Games.create_player_word_approval(valid_attrs)

      assert player_word_approval.approved == true
    end

    test "create_player_word_approval/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player_word_approval(@invalid_attrs)
    end

    test "update_player_word_approval/2 with valid data updates the player_word_approval" do
      player_word_approval = player_word_approval_fixture()
      update_attrs = %{approved: false}

      assert {:ok, %PlayerWordApproval{} = player_word_approval} =
               Games.update_player_word_approval(player_word_approval, update_attrs)

      assert player_word_approval.approved == false
    end

    test "update_player_word_approval/2 with invalid data returns error changeset" do
      player_word_approval = player_word_approval_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Games.update_player_word_approval(player_word_approval, @invalid_attrs)

      assert player_word_approval == Games.get_player_word_approval!(player_word_approval.id)
    end

    test "delete_player_word_approval/1 deletes the player_word_approval" do
      player_word_approval = player_word_approval_fixture()

      assert {:ok, %PlayerWordApproval{}} =
               Games.delete_player_word_approval(player_word_approval)

      assert_raise Ecto.NoResultsError, fn ->
        Games.get_player_word_approval!(player_word_approval.id)
      end
    end

    test "change_player_word_approval/1 returns a player_word_approval changeset" do
      player_word_approval = player_word_approval_fixture()
      assert %Ecto.Changeset{} = Games.change_player_word_approval(player_word_approval)
    end
  end

  describe "player_definition_votes" do
    alias DictionaryGame.Games.PlayerDefinitionVote

    import DictionaryGame.GamesFixtures

    @invalid_attrs %{}

    test "list_player_definition_votes/0 returns all player_definition_votes" do
      player_definition_votes = player_definition_votes_fixture()
      assert Games.list_player_definition_votes() == [player_definition_votes]
    end

    test "get_player_definition_votes!/1 returns the player_definition_votes with given id" do
      player_definition_votes = player_definition_votes_fixture()

      assert Games.get_player_definition_votes!(player_definition_votes.id) ==
               player_definition_votes
    end

    test "create_player_definition_votes/1 with valid data creates a player_definition_votes" do
      valid_attrs = %{}

      assert {:ok, %PlayerDefinitionVote{} = player_definition_votes} =
               Games.create_player_definition_votes(valid_attrs)
    end

    test "create_player_definition_votes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player_definition_votes(@invalid_attrs)
    end

    test "update_player_definition_votes/2 with valid data updates the player_definition_votes" do
      player_definition_votes = player_definition_votes_fixture()
      update_attrs = %{}

      assert {:ok, %PlayerDefinitionVote{} = player_definition_votes} =
               Games.update_player_definition_votes(player_definition_votes, update_attrs)
    end

    test "update_player_definition_votes/2 with invalid data returns error changeset" do
      player_definition_votes = player_definition_votes_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Games.update_player_definition_votes(player_definition_votes, @invalid_attrs)

      assert player_definition_votes ==
               Games.get_player_definition_votes!(player_definition_votes.id)
    end

    test "delete_player_definition_votes/1 deletes the player_definition_votes" do
      player_definition_votes = player_definition_votes_fixture()

      assert {:ok, %PlayerDefinitionVote{}} =
               Games.delete_player_definition_votes(player_definition_votes)

      assert_raise Ecto.NoResultsError, fn ->
        Games.get_player_definition_votes!(player_definition_votes.id)
      end
    end

    test "change_player_definition_votes/1 returns a player_definition_votes changeset" do
      player_definition_votes = player_definition_votes_fixture()
      assert %Ecto.Changeset{} = Games.change_player_definition_votes(player_definition_votes)
    end
  end
end
