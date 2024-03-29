defmodule DictionaryGameWeb.GameLive.Show do
  use DictionaryGameWeb, :live_view

  alias DictionaryGame.{Games, Dictionary}
  alias DictionaryGame.Games.{Round, Player}
  alias DictionaryGame.Dictionary.{Definition}

  require Logger

  @impl true
  def mount(%{"id" => game_id}, session, socket) do
    # Get the game by game id.
    game = Games.get_game!(game_id)
    # Get a player by game id and user_id.
    player = Games.get_player(game_id, session["user_id"]) || %Player{}
    # Get the list of players.
    players = Games.list_players(game_id)

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
        player.id && round ->
          Dictionary.get_definition(player.id, round.word_id) || %Definition{}

        true ->
          %Definition{}
      end

    # Get the list of definitions for the current word if round exists (may be `[]`).
    definitions =
      cond do
        round -> Dictionary.list_definitions(game_id, round.word_id)
        true -> []
      end

    # Get the list of votes for this round if round exists (may be `[]`).
    definition_votes =
      cond do
        round -> Games.list_player_definition_votes(round.id)
        true -> []
      end

    topic = "game:" <> game_id

    if connected?(socket) do
      DictionaryGameWeb.Endpoint.subscribe(topic)

      if player.name do
        DictionaryGameWeb.Presence.track(self(), topic, player.name, %{})
      end
    end

    {:ok,
     socket
     |> assign(
       user_id: session["user_id"],
       player: player,
       game: game,
       round: round,
       word_approvals: word_approvals,
       definition: definition,
       definitions: Enum.sort(definitions),
       definition_votes: definition_votes,
       topic: topic,
       # TODO: load initial user list?
       player_names: [],
       players: players
     )}
  end

  @impl true
  def handle_params(%{"id" => game_id}, uri, socket) do
    {:noreply,
     socket
     |> assign(
       page_title: page_title(socket.assigns.live_action, game_id),
       url: uri,
       game: Games.get_game!(game_id)
     )}
  end

  @impl true
  def handle_info(
        %{event: "round_created", payload: %{round: round, definitions: definitions}},
        socket
      ) do
    {:noreply,
     socket
     |> assign(round: round, definition: %Definition{}, definitions: definitions)
     |> put_flash(:info, "Round #{round.round_number} started.")}
  end

  @impl true
  def handle_info(
        %{event: "game_deleted", payload: deleted_by},
        socket
      ) do
    {:noreply,
     socket
     |> put_flash(:info, "Game ended by #{deleted_by.name}")
     |> push_redirect(to: Routes.game_index_path(socket, :index))}
  end

  @impl true
  def handle_info(
        %{
          event: "game_reset",
          payload: %{round: round, players: players, definitions: definitions, reset_by: reset_by}
        },
        socket
      ) do
    {:noreply,
     socket
     |> put_flash(:info, "Game reset by #{reset_by.name}")
     |> assign(
       round: round,
       players: players,
       player: Enum.find(players, &(&1.id == socket.assigns.player.id)),
       word_approvals: [],
       definition: %Definition{},
       definitions: definitions,
       definition_votes: []
     )}
  end

  @impl true
  def handle_info(
        %{
          event: "known_word_created",
          payload: %{
            known_word: known_word,
            round: round,
            player: player,
            definitions: definitions
          }
        },
        socket
      ) do
    {:noreply,
     socket
     |> assign(round: round, definitions: definitions)
     |> put_flash(:info, "#{known_word.word.word} known by #{player.name}.")}
  end

  @impl true
  def handle_info(
        %{
          event: "word_approval_created",
          payload: %{word_approvals: word_approvals, round: round}
        },
        socket
      ) do
    {:noreply, socket |> assign(word_approvals: word_approvals, round: round)}
  end

  @impl true
  def handle_info(%{event: "definition_created", payload: definition}, socket) do
    definitions = socket.assigns.definitions ++ [definition]

    players = Games.list_players(socket.assigns.game.id)

    # Update round.are_definitions_submitted if necessary.
    {:ok, round} =
      cond do
        are_definitions_submitted?(socket.assigns.round, players, definitions) ->
          Games.update_round(socket.assigns.round, socket.assigns.round.word, %{
            are_definitions_submitted: true
          })

        true ->
          {:ok, socket.assigns.round}
      end

    # Fetch our dear players updated definition.
    player_definition =
      Dictionary.get_definition(socket.assigns.player.id, round.word_id) || %Definition{}

    # Get an updated definition_votes list.
    definition_votes = Games.list_player_definition_votes(round.id)

    {:noreply,
     socket
     |> assign(
       definitions: Enum.sort(definitions),
       round: round,
       definition: player_definition,
       definition_votes: definition_votes
     )}
  end

  @impl true
  def handle_info(
        %{
          event: "definition_vote_created",
          payload: %{
            vote: _vote,
            round: round,
            definition_votes: definition_votes
          }
        },
        socket
      ) do
    # Fetch an updated players list from the database.
    players = Games.list_players(socket.assigns.game.id)

    # This players score may have been updated by another players vote.
    player = Enum.find(players, &(&1.id == socket.assigns.player.id))

    {:noreply,
     socket
     |> assign(
       definition_votes: definition_votes,
       round: round,
       players: players,
       player: player
     )}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    player_names = DictionaryGameWeb.Presence.list(socket.assigns.topic) |> Map.keys()

    # # Update joins.
    # for {name, _} <- Map.keys(joins) do
    #   Logger.info(join: name)
    #   Logger.info(Enum.find(players, &(&1.name == name)))
    # end

    # # Update leaves.
    # for {name, _} <- leaves do
    #   Logger.info(leave: name)
    #   Logger.info(Enum.find(players, &(&1.name == name)))
    # end

    # Update players list.
    players = Games.list_players(socket.assigns.game.id)

    # Broadcast players_online event to general games topic (so index view can be updated).
    DictionaryGameWeb.Endpoint.broadcast("games", "players_online", socket.assigns.game.id)
    
    {:noreply, socket |> assign(player_names: player_names, players: players)}
  end

  @impl true
  def handle_event("approve_word", _value, socket) do
    round = socket.assigns.round

    # Create player word approval, does nothing if already exists (this shouldn't happen, but maybe a user can double click really fast).
    case Games.create_player_word_approval(socket.assigns.player, round.word, round) do
      {:ok, approval} ->
        word_approvals = socket.assigns.word_approvals ++ [approval]

        players = Games.list_players(socket.assigns.game.id)
        Logger.info(players: players)

        # Update round.is_approved and create PlayedWord if word is approved by all players.
        {:ok, round} =
          cond do
            is_word_approved?(round, players, word_approvals) ->
              # Create PlayedWord since everyone has approved the word and it will now be played.
              Games.create_played_word(socket.assigns.game, round.word)
              # Update round.
              Games.update_round(round, round.word, %{
                is_approved: true
              })

            true ->
              {:ok, round}
          end

        # Broadcast word_approval_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "word_approval_created",
          %{
            word_approvals: word_approvals,
            round: round
          }
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
        word = Dictionary.get_unknown_word!(socket.assigns.game.id)
        # Update round.
        {:ok, round} = Games.update_round(socket.assigns.round, word)
        # Get definitions.
        definitions = Dictionary.list_definitions(socket.assigns.game.id, word.id)

        # Broadcast known_word_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "known_word_created",
          %{
            known_word: known_word,
            round: round,
            player: socket.assigns.player,
            definitions: definitions
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
      {:ok, game} ->
        # Broadcast game_deleted event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "game_deleted",
          socket.assigns.player
        )

        # Broadcast the game_deleted event to the general games topic so the index page can be updated.
        DictionaryGameWeb.Endpoint.broadcast("games", "game_deleted", game.id)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("play_again", _value, socket) do
    # Reset game state.
    game = socket.assigns.game
    # Delete all rounds.
    Games.delete_rounds(game.id)
    # Get a new word.
    word = Dictionary.get_unknown_word!(game.id)
    # Create a new initial round.
    {:ok, round} = Games.create_round(game, word, %{round_number: 1})
    # Reset players.
    Games.reset_player_scores(game.id)
    # Fetch players.
    players = Games.list_players(game.id)
    # Get the definitions for the round word (will only contain the real definition).
    definitions = Dictionary.list_definitions(game.id, word.id)
    # Broadcast game_reset event to every player (including the player who triggered the event).
    DictionaryGameWeb.Endpoint.broadcast(
      socket.assigns.topic,
      "game_reset",
      %{round: round, players: players, definitions: definitions, reset_by: socket.assigns.player}
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("vote_for_definition", %{"definition_id" => definition_id}, socket) do
    # Create PlayerDefinitionVote.
    case Games.create_player_definition_vote(
           socket.assigns.player,
           Enum.find(socket.assigns.definitions, &(&1.id == definition_id)),
           socket.assigns.round
         ) do
      {:ok, vote} ->
        {:ok, player} =
          case Enum.find(socket.assigns.definitions, &(&1.id == definition_id)) do
            %Definition{is_real: true} ->
              # The voting player receives 10 points for guessing the correct definition.
              Games.increment_player_score(socket.assigns.player, 10)

            %Definition{is_real: false, player_id: player_id} ->
              # The player whose definition was voted for gets 5 points for fooling the voting player.
              player_to_increment = Enum.find(socket.assigns.players, &(&1.id == player_id))
              Games.increment_player_score(player_to_increment, 5)
              {:ok, socket.assigns.player}
          end

        # Fetch an updated players list from the database.
        players = Games.list_players(socket.assigns.game.id)

        # Concatenate existing votes with new vote.
        definition_votes = socket.assigns.definition_votes ++ [vote]

        # Update round.are_votes_submitted if necessary.
        {:ok, round} =
          cond do
            are_votes_submitted?(socket.assigns.round, players, definition_votes) ->
              # Update player.display_score to be the same as player.score.
              for p <- players do
                Games.update_player(p, %{display_score: p.score})
              end

              Games.update_round(socket.assigns.round, socket.assigns.round.word, %{
                are_votes_submitted: true
              })

            true ->
              {:ok, socket.assigns.round}
          end

        Logger.info(round: round)

        # Broadcast definition_vote_created event to every player (including the player who triggered the event).
        DictionaryGameWeb.Endpoint.broadcast(
          socket.assigns.topic,
          "definition_vote_created",
          %{vote: vote, round: round, definition_votes: definition_votes}
        )

        {:noreply, assign(socket, player: player)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("next_round", _value, socket) do
    # Create next round.
    {:ok, round} = create_next_round(socket.assigns.game)
    # Fetch the definition list for the round word (will only contain the real definition).
    definitions = Dictionary.list_definitions(socket.assigns.game.id, round.word_id)

    # Broadcast round_created event to every player (including the player who triggered the event).
    DictionaryGameWeb.Endpoint.broadcast(socket.assigns.topic, "round_created", %{
      round: round,
      definitions: definitions
    })

    {:noreply, socket}
  end

  # TODO: make game name?
  defp page_title(:show, game_id), do: "Game: #{game_id}"

  defp create_next_round(game) do
    word = Dictionary.get_unknown_word!(game.id)

    case Games.get_current_round(game.id) do
      %Round{} = round -> Games.create_round(game, word, %{round_number: round.round_number + 1})
      nil -> Games.create_round(game, word, %{round_number: 1})
    end
  end

  defp is_word_approved?(round, players, approvals) do
    # Has every in-game player approved the current word?
    Enum.reduce(players, true, fn p, acc ->
      Enum.any?(approvals, fn x ->
        x.player_id == p.id && x.word_id == round.word_id
      end) && acc
    end)
  end

  defp are_definitions_submitted?(round, players, definitions) do
    # Has every player submitted a definition for the current word?
    Enum.reduce(players, true, fn p, acc ->
      Enum.any?(definitions, fn d ->
        d.player_id == p.id && d.word_id == round.word_id
      end) && acc
    end)
  end

  defp are_votes_submitted?(round, players, votes) do
    # Has every player voted for a definition?
    Enum.reduce(players, true, fn p, acc ->
      Enum.any?(votes, fn x -> x.player_id == p.id && x.round_id == round.id end) &&
        acc
    end)
  end

  defp to_integer(string) do
    char_list =
      string
      |> String.normalize(:nfc)
      |> String.to_charlist()

    Enum.reduce(char_list, fn x, acc -> x + acc end)
  end
end
