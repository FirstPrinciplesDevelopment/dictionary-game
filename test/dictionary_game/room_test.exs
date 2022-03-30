defmodule DictionaryGame.RoomsTest do
  use DictionaryGame.DataCase

  alias DictionaryGame.Rooms

  describe "rooms" do
    alias DictionaryGame.Rooms.Room

    import DictionaryGame.RoomsFixtures

    @invalid_attrs %{description: nil, is_censored: nil, is_public: nil, name: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{description: "some description", is_censored: true, is_public: true, name: "some name"}

      assert {:ok, %Room{} = room} = Rooms.create_room(valid_attrs)
      assert room.description == "some description"
      assert room.is_censored == true
      assert room.is_public == true
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{description: "some updated description", is_censored: false, is_public: false, name: "some updated name"}

      assert {:ok, %Room{} = room} = Rooms.update_room(room, update_attrs)
      assert room.description == "some updated description"
      assert room.is_censored == false
      assert room.is_public == false
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end
end
