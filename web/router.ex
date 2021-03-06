defmodule Fenix.Router do
  use Fenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Parsers, parsers: [:urlencoded, :multipart]
    plug Plug.Parsers, parsers: [:urlencoded, :json],
                       pass:  ["text/*"],
                       json_decoder: Poison
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Fenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/khala", KhalaController, except: [:new, :edit]
    resources "/castes", CasteController, except: [:new, :edit]
    resources "/ranks", RankController, except: [:new, :edit]

  end

  # Other scopes may use custom stacks.
  # scope "/api", Fenix do
  #   pipe_through :api
  # end
end
