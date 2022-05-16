defmodule DictionaryGameWeb.Components do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  Renders a tutorial.

  ## Examples

      <.how_to_play />
  """
  def how_to_play(assigns) do
    ~H"""
      <div class="m-8">
          <ol class="list-decimal">
          <li>Create or join a game.</li>
          <li>Make up a name for yourself.</li>
          <li>Get some friends to join your game.</li>
          <li>Follow the instructions.</li>
        </ol>
      </div>
    """
  end

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  The modal recieves an `:id` option to uniquely identify it
  and to allow multiple modals to be managed in the DOM at the same time.

  ## Examples

      <.modal id="new-game" return_to={Routes.game_index_path(@socket, :index)}>
        <.live_component
          module={DictionaryGameWeb.GameLive.FormComponent}
          id={@game.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.game_index_path(@socket, :index)}
          game: @game
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id={"modal-#{@id}"} class="fixed top-0 left-0 fade-in opacity-10 min-w-full min-h-full bg-[rgba(0,0,0,0.6)] hidden" phx-remove={hide_modal(@id)}>
      <div class="flex min-h-screen flex-col justify-center overflow-hidden">
        <div
          id={"modal-content-#{@id}"}
          class="relative justify-center bg-white fade-in-scale max-w-md w-full mx-auto rounded-lg shadow-lg"
          phx-click-away={JS.dispatch("click", to: "#close")}
          phx-window-keydown={JS.dispatch("click", to: "#close")}
          phx-key="escape"
        >
          <%= if @return_to do %>
            <%= live_patch "✖",
              to: @return_to,
              id: "close",
              class: "float-right text-2xl font-bold text-gray-500 cursor-pointer hover:text-gray-900 m-2",
              phx_click: hide_modal(@id)
            %>
          <% else %>
            <a id="close" href="#" class="float-right text-2xl font-bold text-gray-500 cursor-pointer hover:text-gray-900 m-2" phx-click={hide_modal(@id)}>✖</a>
          <% end %>

          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def hide_modal(id, js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal-#{id}", transition: "fade-out")
    |> JS.hide(to: "#modal-content-#{id}", transition: "fade-out-scale")
  end

  def show_modal(id, js \\ %JS{}) do
    js
    |> JS.show(to: "#modal-content-#{id}")
    |> JS.show(to: "#modal-#{id}")
  end
end
