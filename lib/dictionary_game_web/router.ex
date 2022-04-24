defmodule DictionaryGameWeb.Router do
  use DictionaryGameWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DictionaryGameWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DictionaryGame.UserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DictionaryGameWeb do
    pipe_through :browser

    live "/", RoomLive.Index, :index
    # live "/rooms/new", RoomLive.Index, :new
    # live "/rooms/:id/edit", RoomLive.Index, :edit
    live "/:id", RoomLive.Show, :show
    # live "/rooms/:id/show/edit", RoomLive.Show, :edit

    # live "/players", PlayerLive.Index, :index
    # live "/players/new", PlayerLive.Index, :new
    # live "/players/:id/edit", PlayerLive.Index, :edit
    # live "/players/:id", PlayerLive.Show, :show
    # live "/players/:id/show/edit", PlayerLive.Show, :edit

    resources "/words", WordController

    live "/definitions", DefinitionLive.Index, :index
    live "/definitions/new", DefinitionLive.Index, :new
    live "/definitions/:id/edit", DefinitionLive.Index, :edit

    live "/definitions/:id", DefinitionLive.Show, :show
    live "/definitions/:id/show/edit", DefinitionLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", DictionaryGameWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DictionaryGameWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
