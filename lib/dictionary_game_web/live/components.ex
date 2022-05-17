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
      <div class="m-8 text-blue-900">
        <ol class="list-decimal">
          <li>
            <details>
              <summary class="cursor-pointer text-lg">Create or join a game.</summary>
              <div class="my-8">
                <div class="text-lg">Look for these buttons:</div>
                <div class="ml-4">
                  <button class="text-green-600 border-2 border-green-600 text-lg md:text-xl font-bold py-1 md:py-2 px-4 rounded-full">
                    New&nbsp;Game
                  </button>
                  <div class="pt-2 text-lg md:text-xl font-bold text-blue-500 cursor-pointer">Join-></div>
                </div>
              </div>
            </details>
          </li>
          <li>
            <details>
              <summary class="cursor-pointer text-lg">Make up a name for yourself.</summary>
              <div class="my-8">
                <span class="text-lg">Example:</span>
                <div class="ml-4">
                  <label class="block font-medium">Player Name</label>
                  <input type="text" class="rounded-full block mb-4 border-2 border-blue-500" placeholder="Player Name" value="Bear Claw" disabled>
                </div>
              </div>
            </details>
          </li>
          <li>
            <details>
              <summary class="cursor-pointer text-lg">Get some friends to join your game.</summary>
              <div class="my-8">
                <div class="text-lg">Look for this button:</div>
                <div class="ml-4">
                  <button class="text-blue-500 border-2 border-blue-500 text-xl font-bold py-2 px-4 my-4 rounded-full">
                    Copy&nbsp;Link
                  </button>
                  <div id="alert-info" class="rounded-full bg-green-200 px-3 max-w-fit md:inline-flex md:ml-4"></div>
                </div>
              </div>
            </details>
          </li>
          <li>
            <details>
              <summary class="cursor-pointer text-lg">Follow the instructions.</summary>
              <div class="my-8">
                <span class="text-lg">Example:</span>
                <p class="m-4 italic">Write a convincing definition for <span class="font-semibold">numbat</span>.</p>
              </div>
            </details>
          </li>
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
