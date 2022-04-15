defmodule DictionaryGameWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.room_index_path(@socket, :index)}>
        <.live_component
          module={DictionaryGameWeb.RoomLive.FormComponent}
          id={@room.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.room_index_path(@socket, :index)}
          room: @room
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="fade-in opacity-10 fixed left-0 top-0 min-w-full min-h-full overflow-auto bg-[rgba(0,0,0,0.4)] hidden" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="bg-white fade-in-scale m-64 max-w-md mx-auto rounded-lg shadow-lg"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch "✖",
            to: @return_to,
            id: "close",
            class: "float-right text-2xl font-bold text-gray-500 cursor-pointer hover:text-gray-900 m-2",
            phx_click: hide_modal()
          %>
        <% else %>
         <a id="close" href="#" class="float-right text-2xl font-bold text-gray-500 cursor-pointer hover:text-gray-900 m-2" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  def hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end

  def show_modal(js \\ %JS{}) do
    js
    |> JS.show(to: "#modal-content")
    |> JS.show(to: "#modal")
  end
end
