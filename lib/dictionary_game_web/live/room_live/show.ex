defmodule DictionaryGameWeb.RoomLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.{Rooms, Games, Dictionary}
  alias DictionaryGame.Games.{Round}
  alias DictionaryGame.Rooms.Player
  alias DictionaryGame.Dictionary.{Definition}

  require Logger

  @impl true
  def mount(%{"id" => room_id}, session, socket) do
    # Get the room by room id.
    room = Rooms.get_room!(room_id)
    # Get a player by room id and user_id.
    player = Rooms.get_player(room.id, session["user_id"]) || %Player{}
    # Get the game if it exists.
    game = Games.get_game(room.id)
    # Get the players score if it exists.
    score =
      cond do
        game && player ->
          Games.get_score(game.id, player.id)

        true ->
          nil
      end

    # Get the round only if the game exists (may be `nil`).
    round =
      cond do
        game -> Games.get_current_round(game.id)
        true -> nil
      end

    # Get the word approvals only if the round exists (may be `[]`).
    word_approvals =
      cond do
        round -> Games.list_player_word_approvals(round.id)
        true -> []
      end

    # Get the definition only if player and round exist (may be "empty" `%Definition{}`).
    definition =
      cond do
        player && round ->
          Dictionary.get_definition(player.id, round.word_id) || %Definition{}

        true ->
          %Definition{}
      end

    topic = "room:" <> room_id

    if connected?(socket) do
      DictionaryGameWeb.Endpoint.subscribe(topic)

      if player do
        DictionaryGameWeb.Presence.track(self(), topic, player.name, %{})
      end
    end

    {:ok,
     socket
     |> assign(
       user_id: session["user_id"],
       player: player,
       definition: definition,
       score: score,
       room: room,
       game: game,
       round: round,
       word_approvals: word_approvals,
       topic: topic,
       # TODO: load initial user list?
       player_list: []
     )}
  end

  @impl true
  def handle_params(%{"id" => room_id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action, room_id))
     |> assign(:room, Rooms.get_room!(room_id))}
  end

  @impl true
  def handle_info(%{event: "game_created", payload: %{game: game, round: round}}, socket) do
    Logger.info(payload: game)

    # Create a score for the player.
    {:ok, score} = Games.create_score(game, socket.assigns.player)

    {:noreply,
     socket |> assign(game: game, round: round, score: score) |> put_flash(:info, "Game started.")}
  end

  @impl true
  def handle_info(%{event: "game_deleted", payload: delete_by}, socket) do
    {:noreply,
     socket
     |> assign(game: nil, score: nil, round: nil, word_approvals: [])
     |> put_flash(:info, "Game ended by #{delete_by.name}.")}
  end

  @impl true
  def handle_info(
        %{
          event: "known_word_created",
          payload: %{known_word: known_word, round: round, player: player}
        },
        socket
      ) do
    {:noreply,
     socket
     |> assign(round: round)
     |> put_flash(:info, "#{known_word.word.word} known by #{player.name}.")}
  end

  @impl true
  def handle_info(%{event: "word_approval_created", payload: approval}, socket) do
    word_approvals = socket.assigns.word_approvals ++ [approval]

    players = Rooms.list_players(socket.assigns.room.id)

    # Has every player approved the current word?
    approved? =
      Enum.reduce(players, true, fn p, acc ->
        Enum.any?(word_approvals, fn x ->
          x.player_id == p.id && x.word_id == socket.assigns.round.word_id
        end) && acc
      end)

    # Update round.is_approved if necessary.
    {:ok, round} =
      cond do
        approved? ->
          Games.update_round(socket.assigns.round, socket.assigns.round.word, %{
            is_approved: approved?
          })

        true ->
          {:ok, socket.assigns.round}
      end

    {:noreply, socket |> assign(word_approvals: word_approvals, round: round)}
  end

  @impl true
  def handle_info(%{event: "definition_created", payload: definition}, socket) do
    definitions = socket.assigns.definitions ++ [definition]

    players = Rooms.list_players(socket.assigns.room.id)

    # Has every player submitted a definition for the current word?
    definitions_submitted? =
      Enum.reduce(players, true, fn p, acc ->
        Enum.any?(definitions, fn d ->
          d.player_id == p.id && d.word_id == socket.assigns.round.word_id
        end) && acc
      end)

    # Update round.are_definitions_submitted if necessary.
    {:ok, round} =
      cond do
        definitions_submitted? ->
          Games.update_round(socket.assigns.round, socket.assigns.round.word, %{
            are_definitions_submitted: definitions_submitted?
          })

        true ->
          {:ok, socket.assigns.round}
      end

    {:noreply, socket |> assign(definitions: definitions, round: round)}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    Logger.info(joins: joins, leaves: leaves)

    player_list = DictionaryGameWeb.Presence.list(socket.assigns.topic) |> Map.keys()
    Logger.info(player_list: player_list)

    {:noreply, socket |> assign(player_list: player_list)}
  end

  @impl true
  def handle_event("start_game", _value, socket) do
    # Create game if one doesn't already exist.
    case Games.get_or_create_game(socket.assigns.room.id) do
      {:ok, game} ->
        # Create round.
        {:ok, round} = create_next_round(game)
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast game_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "game_created", %{
          game: game,
          round: round
        })

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("approve_word", _value, socket) do
    # Create player word approval, does nothing if already exists (this shouldn't happen, but maybe a user can double click really fast).
    round = socket.assigns.round

    case Games.create_player_word_approval(socket.assigns.player, round.word, round) do
      {:ok, approval} ->
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast word_approval_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "word_approval_created",
          approval
        )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("create_known_word", _value, socket) do
    # Create known word record, unless it already exists (possible race).
    case Games.create_known_word(socket.assigns.game, socket.assigns.round.word) do
      {:ok, known_word} ->
        # Get a new word for the round.
        word = fetch_new_word(socket.assigns.game)
        {:ok, round} = Games.update_round(socket.assigns.round, word)
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast game_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "known_word_created",
          %{
            known_word: known_word,
            round: round,
            player: socket.assigns.player
          }
        )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("end_game", _value, socket) do
    # Delete game.
    case Games.delete_game(socket.assigns.game) do
      {:ok, _game} ->
        # TODO: Make sure delete cascades properly.
        # TODO: Should this move to the data access (Context) layer?
        # Broadcast game_deleted event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "game_deleted",
          socket.assigns.player
        )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # TODO: make room name?
  defp page_title(:show, room_id), do: "Room: #{room_id}"

  defp create_next_round(game) do
    word = fetch_new_word(game)

    case Games.get_current_round(game.id) do
      %Round{} = round -> Games.create_round(game, word, %{round_number: round.round_number + 1})
      nil -> Games.create_round(game, word, %{round_number: 1})
    end
  end

  defp fetch_new_word(game) do
    Dictionary.get_unknown_word!(game.id)
  end
end
