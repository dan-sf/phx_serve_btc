defmodule PhxServeBtcWeb.Router do
  use PhxServeBtcWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxServeBtcWeb do
    pipe_through :api
    resources "/btc_candles", BitcoinController, except: [:new, :edit]
    get "/btc_month/:month", BitcoinController, :get_month
  end
end
