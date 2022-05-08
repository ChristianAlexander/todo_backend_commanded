defmodule TodoBackendWeb.Router do
  use TodoBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoBackendWeb do
    pipe_through :api

    resources "/todos", TodoController
    delete "/todos", TodoController, :delete_all
  end
end
