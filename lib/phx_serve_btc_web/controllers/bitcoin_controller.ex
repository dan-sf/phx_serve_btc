defmodule PhxServeBtcWeb.BitcoinController do
  use PhxServeBtcWeb, :controller

  alias PhxServeBtc.CandleData
  alias PhxServeBtc.CandleData.Bitcoin

  action_fallback PhxServeBtcWeb.FallbackController

  def index(conn, _params) do
    btc_candles = CandleData.list_btc_candles()
    render(conn, :index, btc_candles: btc_candles)
  end

  def get_month(conn, _params) do
    year_month = conn.params["month"]
    # Validate iso month format YYYY-MM
    true = Regex.match?(~r/20[0-9][0-9]-(0[0-9]|1[0-2])/, year_month)

    [year, month] = String.split(year_month, "-")
    start_date = Date.from_erl!({String.to_integer(year), String.to_integer(month), 1})
    end_date = Date.add(start_date, Date.days_in_month(start_date))

    btc_candles = CandleData.list_btc_candles_date_range(start_date, end_date)
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
