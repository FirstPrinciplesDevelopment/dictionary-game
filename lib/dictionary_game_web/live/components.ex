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
    <div class="text-blue-900">
        <h3 class="text-xl inline-block font-bold m-4 text-blue-600 text-center rounded-full bg-blue-100 px-4">How To Play
        </h3>
        <div class="block">
            <div class="h-80 overflow-hidden align-center relative p-0 list-none rounded-lg my-4">
                <input class="carousel__activator hidden" type="radio" name="carousel" id="1" checked="checked" />
                <input class="carousel__activator hidden" type="radio" name="carousel" id="2" />
                <input class="carousel__activator hidden" type="radio" name="carousel" id="3" />
                <input class="carousel__activator hidden" type="radio" name="carousel" id="4" />
                <input class="carousel__activator hidden" type="radio" name="carousel" id="5" />
                <div class="carousel__controls hidden">
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-l-4 border-slate-700 origin-center -rotate-45 left-4"
                        for="5"></label>
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-r-4 border-slate-700 origin-center rotate-45 right-4"
                        for="2"></label>
                </div>
                <div class="carousel__controls hidden">
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-l-4 border-slate-700 origin-center -rotate-45 left-4"
                        for="1"></label>
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-r-4 border-slate-700 origin-center rotate-45 right-4"
                        for="3"></label>
                </div>
                <div class="carousel__controls hidden">
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-l-4 border-slate-700 origin-center -rotate-45 left-4"
                        for="2"></label>
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-r-4 border-slate-700 origin-center rotate-45 right-4"
                        for="4"></label>
                </div>
                <div class="carousel__controls hidden">
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-l-4 border-slate-700 origin-center -rotate-45 left-4"
                        for="3"></label>
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-r-4 border-slate-700 origin-center rotate-45 right-4"
                        for="5"></label>
                </div>
                <div class="carousel__controls hidden">
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-l-4 border-slate-700 origin-center -rotate-45 left-4"
                        for="4"></label>
                    <label
                        class="z-10 block absolute top-36 -mt-4 h-7 w-7 cursor-pointer opacity-30 hover:opacity-100 border-t-4 border-r-4 border-slate-700 origin-center rotate-45 right-4"
                        for="1"></label>
                </div>
                <div class="carousel__track transition ease-in-out duration-500 absolute inset-0 opacity-1">
                    <li
                        class="carousel__slide text-center px-8 inset-0 absolute opacity-1 h-full overflow-y-auto overflow-hidden">
                        <h3 class="text-xl font-bold">Create or join a game.</h3>
                        <div class="my-8">
                            <div class="mx-4">
                                <p>
                                    Click <a
                                        class="inline text-lg md:text-xl font-bold text-blue-500 hover:text-blue-600 active:text-blue-700 hover:underline cursor-pointer">Join-></a>
                                    to join an existing game,
                                </p>
                                <p class="underline my-4">or</p>
                                <p>
                                    click <button
                                        class="text-green-600 hover:text-white active:text-white border-2 border-green-600 text-lg md:text-xl font-bold hover:bg-green-600 active:bg-green-700 active:border-green-700 py-1 md:py-2 px-4 rounded-full">
                                        New&nbsp;Game
                                    </button> to create a new game.
                                </p>
                            </div>
                        </div>

                    </li>
                    <li
                        class="carousel__slide text-center px-8 translate-x-full inset-0 absolute opacity-1 h-full overflow-y-auto overflow-hidden">
                        <h3 class="text-xl font-bold">Make up a name for yourself.</h3>
                        <div class="my-8">
                            <div class="mx-4">
                                <p>
                                    Enter a name for everyone in the game to see, then click
                                    <button
                                        class="text-blue-500 hover:text-white active:text-white border-2 border-blue-500 text-xl font-bold hover:bg-blue-500 active:bg-blue-600 active:border-blue-600 py-2 px-4 rounded-full">
                                        Join&nbsp;Game
                                    </button> when you're ready.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li
                        class="carousel__slide text-center px-8 translate-x-[200%] inset-0 absolute opacity-1 h-full overflow-y-auto overflow-hidden">
                        <h3 class="text-xl font-bold">Get some friends to join your game.</h3>
                        <div class="my-8">
                            <div class="mx-4">
                                <p>You need at least 2 players, so use
                                    <button
                                        class="text-blue-500 hover:text-white active:text-white border-2 border-blue-500 text-xl font-bold hover:bg-blue-500 active:bg-blue-600 py-2 px-4 my-4 rounded-full">
                                        Copy&nbsp;Link
                                    </button> to share the game with friends.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li
                        class="carousel__slide text-center px-8 translate-x-[300%] inset-0 absolute opacity-1 h-full overflow-y-auto overflow-hidden">
                        <h3 class="text-xl font-bold">Follow the instructions.</h3>
                        <div class="my-8">
                            <div class="mx-4">

                                <span class="text-lg">Instructions have a yellow background, here's an example:</span>
                                <p class="mt-8 text-lg bg-amber-100 rounded-lg px-2 py-1 inline-block">Write a convincing
                                    definition for <span
                                        class="font-semibold inline sm:hidden">incomprehensibilities</span><span
                                        class="font-semibold hidden sm:inline">supercalifragilisticexpialidocious</span>.
                                </p>

                            </div>
                        </div>
                    </li>
                    <li
                        class="carousel__slide text-center px-8 translate-x-[400%] inset-0 absolute opacity-1 h-full overflow-y-auto overflow-hidden">
                        <h3 class="text-xl font-bold">Winning the game.</h3>
                        <div class="my-8">
                            <div class="mx-4">
                                <p>Write covincing definitions to bamboozle your friends while guessing the real
                                    definitions. The player with the most points after 3 rounds wins!</p>
                                <p>
                                <div class="text-xl font-bold text-green-600 animate-bounce mt-8 mx-auto text-center">
                                    Winner!</div>
                                </p>
                            </div>
                        </div>
                    </li>
                </div>
                <div class="carousel__indicators absolute w-full text-center bottom-4">
                    <label
                        class="carousel__indicator h-4 w-4 rounded-full inline-block mx-px z-10 cursor-pointer opacity-30 hover:opacity-75 bg-sky-600"
                        for="1"></label>
                    <label
                        class="carousel__indicator h-4 w-4 rounded-full inline-block mx-px z-10 cursor-pointer opacity-30 hover:opacity-75 bg-sky-600"
                        for="2"></label>
                    <label
                        class="carousel__indicator h-4 w-4 rounded-full inline-block mx-px z-10 cursor-pointer opacity-30 hover:opacity-75 bg-sky-600"
                        for="3"></label>
                    <label
                        class="carousel__indicator h-4 w-4 rounded-full inline-block mx-px z-10 cursor-pointer opacity-30 hover:opacity-75 bg-sky-600"
                        for="4"></label>
                    <label
                        class="carousel__indicator h-4 w-4 rounded-full inline-block mx-px z-10 cursor-pointer opacity-30 hover:opacity-75 bg-sky-600"
                        for="5"></label>
                </div>
            </div>
        </div>
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
