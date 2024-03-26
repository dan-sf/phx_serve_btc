defmodule PhxServeBtcWeb.BitcoinControllerTest do
  use PhxServeBtcWeb.ConnCase

  import PhxServeBtc.CandleDataFixtures

  alias PhxServeBtc.CandleData.Bitcoin

  @create_attrs %{
    close: 120.5,
    high: 120.5,
    low: 120.5,
    open: 120.5,
    currency: "some currency",
    day: ~D[2024-03-25],
    volume: 120.5
  }
  @update_attrs %{
    close: 456.7,
    high: 456.7,
    low: 456.7,
    open: 456.7,
    currency: "some updated currency",
    day: ~D[2024-03-26],
    volume: 456.7
  }
  @invalid_attrs %{close: nil, high: nil, low: nil, open: nil, currency: nil, day: nil, volume: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all btc_candles", %{conn: conn} do
      conn = get(conn, ~p"/api/btc_candles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bitcoin" do
    test "renders bitcoin when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/btc_candles", bitcoin: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/btc_candles/#{id}")

      assert %{
               "id" => ^id,
               "close" => 120.5,
               "currency" => "some currency",
               "day" => "2024-03-25",
               "high" => 120.5,
               "low" => 120.5,
               "open" => 120.5,
               "volume" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/btc_candles", bitcoin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bitcoin" do
    setup [:create_bitcoin]

    test "renders bitcoin when data is valid", %{conn: conn, bitcoin: %Bitcoin{id: id} = bitcoin} do
      conn = put(conn, ~p"/api/btc_candles/#{bitcoin}", bitcoin: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/btc_candles/#{id}")

      assert %{
               "id" => ^id,
               "close" => 456.7,
               "currency" => "some updated currency",
               "day" => "2024-03-26",
               "high" => 456.7,
               "low" => 456.7,
               "open" => 456.7,
               "volume" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bitcoin: bitcoin} do
      conn = put(conn, ~p"/api/btc_candles/#{bitcoin}", bitcoin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bitcoin" do
    setup [:create_bitcoin]

    test "deletes chosen bitcoin", %{conn: conn, bitcoin: bitcoin} do
      conn = delete(conn, ~p"/api/btc_candles/#{bitcoin}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/btc_candles/#{bitcoin}")
      end
    end
  end

  defp create_bitcoin(_) do
    bitcoin = bitcoin_fixture()
    %{bitcoin: bitcoin}
  end
end
