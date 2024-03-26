defmodule PhxServeBtc.CandleDataTest do
  use PhxServeBtc.DataCase

  alias PhxServeBtc.CandleData

  describe "btc_candles" do
    alias PhxServeBtc.CandleData.Bitcoin

    import PhxServeBtc.CandleDataFixtures

    @invalid_attrs %{close: nil, high: nil, low: nil, open: nil, currency: nil, day: nil, volume: nil}

    test "list_btc_candles/0 returns all btc_candles" do
      bitcoin = bitcoin_fixture()
      assert CandleData.list_btc_candles() == [bitcoin]
    end

    test "get_bitcoin!/1 returns the bitcoin with given id" do
      bitcoin = bitcoin_fixture()
      assert CandleData.get_bitcoin!(bitcoin.id) == bitcoin
    end

    test "create_bitcoin/1 with valid data creates a bitcoin" do
      valid_attrs = %{close: 120.5, high: 120.5, low: 120.5, open: 120.5, currency: "some currency", day: ~D[2024-03-25], volume: 120.5}

      assert {:ok, %Bitcoin{} = bitcoin} = CandleData.create_bitcoin(valid_attrs)
      assert bitcoin.close == 120.5
      assert bitcoin.high == 120.5
      assert bitcoin.low == 120.5
      assert bitcoin.open == 120.5
      assert bitcoin.currency == "some currency"
      assert bitcoin.day == ~D[2024-03-25]
      assert bitcoin.volume == 120.5
    end

    test "create_bitcoin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CandleData.create_bitcoin(@invalid_attrs)
    end

    test "update_bitcoin/2 with valid data updates the bitcoin" do
      bitcoin = bitcoin_fixture()
      update_attrs = %{close: 456.7, high: 456.7, low: 456.7, open: 456.7, currency: "some updated currency", day: ~D[2024-03-26], volume: 456.7}

      assert {:ok, %Bitcoin{} = bitcoin} = CandleData.update_bitcoin(bitcoin, update_attrs)
      assert bitcoin.close == 456.7
      assert bitcoin.high == 456.7
      assert bitcoin.low == 456.7
      assert bitcoin.open == 456.7
      assert bitcoin.currency == "some updated currency"
      assert bitcoin.day == ~D[2024-03-26]
      assert bitcoin.volume == 456.7
    end

    test "update_bitcoin/2 with invalid data returns error changeset" do
      bitcoin = bitcoin_fixture()
      assert {:error, %Ecto.Changeset{}} = CandleData.update_bitcoin(bitcoin, @invalid_attrs)
      assert bitcoin == CandleData.get_bitcoin!(bitcoin.id)
    end

    test "delete_bitcoin/1 deletes the bitcoin" do
      bitcoin = bitcoin_fixture()
      assert {:ok, %Bitcoin{}} = CandleData.delete_bitcoin(bitcoin)
      assert_raise Ecto.NoResultsError, fn -> CandleData.get_bitcoin!(bitcoin.id) end
    end

    test "change_bitcoin/1 returns a bitcoin changeset" do
      bitcoin = bitcoin_fixture()
      assert %Ecto.Changeset{} = CandleData.change_bitcoin(bitcoin)
    end
  end
end
