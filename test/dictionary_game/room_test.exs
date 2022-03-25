defmodule DictionaryGame.RoomsTest do
  use DictionaryGame.DataCase

  alias DictionaryGame.Rooms

  describe "rooms" do
    alias DictionaryGame.Rooms.Room

    import DictionaryGame.RoomsFixtures

    @invalid_attrs %{room_code: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Game.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Game.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{room_code: "some room_code"}

      assert {:ok, %Room{} = room} = Game.create_room(valid_attrs)
      assert room.room_code == "some room_code"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{room_code: "some updated room_code"}

      assert {:ok, %Room{} = room} = Game.update_room(room, update_attrs)
      assert room.room_code == "some updated room_code"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_room(room, @invalid_attrs)
      assert room == Game.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Game.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Game.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Game.change_room(room)
    end
  end

  describe "players" do
    alias DictionaryGame.Rooms.Player

    import DictionaryGame.RoomsFixtures

    @invalid_attrs %{is_host: nil, name: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Game.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Game.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{is_host: true, name: "some name"}

      assert {:ok, %Player{} = player} = Game.create_player(valid_attrs)
      assert player.is_host == true
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{is_host: false, name: "some updated name"}

      assert {:ok, %Player{} = player} = Game.update_player(player, update_attrs)
      assert player.is_host == false
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_player(player, @invalid_attrs)
      assert player == Game.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Game.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Game.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Game.change_player(player)
    end
  end

  describe "definitions" do
    alias DictionaryGame.Rooms.Definition

    import DictionaryGame.RoomsFixtures

    @invalid_attrs %{definition: nil, part_of_speech: nil, word: nil}

    test "list_definitions/0 returns all definitions" do
      definition = definition_fixture()
      assert Game.list_definitions() == [definition]
    end

    test "get_definition!/1 returns the definition with given id" do
      definition = definition_fixture()
      assert Game.get_definition!(definition.id) == definition
    end

    test "create_definition/1 with valid data creates a definition" do
      valid_attrs = %{
        definition: "some definition",
        part_of_speech: "some part_of_speech",
        word: "some word"
      }

      assert {:ok, %Definition{} = definition} = Game.create_definition(valid_attrs)
      assert definition.definition == "some definition"
      assert definition.part_of_speech == "some part_of_speech"
      assert definition.word == "some word"
    end

    test "create_definition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_definition(@invalid_attrs)
    end

    test "update_definition/2 with valid data updates the definition" do
      definition = definition_fixture()

      update_attrs = %{
        definition: "some updated definition",
        part_of_speech: "some updated part_of_speech",
        word: "some updated word"
      }

      assert {:ok, %Definition{} = definition} = Game.update_definition(definition, update_attrs)
      assert definition.definition == "some updated definition"
      assert definition.part_of_speech == "some updated part_of_speech"
      assert definition.word == "some updated word"
    end

    test "update_definition/2 with invalid data returns error changeset" do
      definition = definition_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_definition(definition, @invalid_attrs)
      assert definition == Game.get_definition!(definition.id)
    end

    test "delete_definition/1 deletes the definition" do
      definition = definition_fixture()
      assert {:ok, %Definition{}} = Game.delete_definition(definition)
      assert_raise Ecto.NoResultsError, fn -> Game.get_definition!(definition.id) end
    end

    test "change_definition/1 returns a definition changeset" do
      definition = definition_fixture()
      assert %Ecto.Changeset{} = Game.change_definition(definition)
    end
  end
end
