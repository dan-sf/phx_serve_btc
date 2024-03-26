defmodule PhxServeBtcWeb.Router do
  use PhxServeBtcWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxServeBtcWeb do
    pipe_through :api
  end
end
