defmodule PhxServeBtcWeb.BitcoinController do
  use PhxServeBtcWeb, :controller

  alias PhxServeBtc.CandleData
  alias PhxServeBtc.CandleData.Bitcoin

  action_fallback PhxServeBtcWeb.FallbackController

  def index(conn, _params) do
    btc_candles = CandleData.list_btc_candles()
    render(conn, :index, btc_candles: btc_candles)
  end

  def create(conn, %{"bitcoin" => bitcoin_params}) do
    with {:ok, %Bitcoin{} = bitcoin} <- CandleData.create_bitcoin(bitcoin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/btc_candles/#{bitcoin}")
      |> render(:show, bitcoin: bitcoin)
    end
  end

  def show(conn, %{"id" => id}) do
    bitcoin = CandleData.get_bitcoin!(id)
    render(conn, :show, bitcoin: bitcoin)
  end

  def update(conn, %{"id" => id, "bitcoin" => bitcoin_params}) do
    bitcoin = CandleData.get_bitcoin!(id)

    with {:ok, %Bitcoin{} = bitcoin} <- CandleData.update_bitcoin(bitcoin, bitcoin_params) do
      render(conn, :show, bitcoin: bitcoin)
    end
  end

  def delete(conn, %{"id" => id}) do
    bitcoin = CandleData.get_bitcoin!(id)

    with {:ok, %Bitcoin{}} <- CandleData.delete_bitcoin(bitcoin) do
      send_resp(conn, :no_content, "")
    end
  end
end
