defmodule ReachWeb.Router do
  use ReachWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReachWeb do
    pipe_through :api
  end
end
