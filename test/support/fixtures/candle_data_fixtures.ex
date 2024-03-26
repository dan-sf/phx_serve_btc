defmodule PhxServeBtc.CandleDataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxServeBtc.CandleData` context.
  """

  @doc """
  Generate a unique bitcoin day.
  """
  def unique_bitcoin_day do
    raise "implement the logic to generate a unique bitcoin day"
  end

  @doc """
  Generate a bitcoin.
  """
  def bitcoin_fixture(attrs \\ %{}) do
    {:ok, bitcoin} =
      attrs
      |> Enum.into(%{
        close: 120.5,
        currency: "some currency",
        day: unique_bitcoin_day(),
        high: 120.5,
        low: 120.5,
        open: 120.5,
        volume: 120.5
      })
      |> PhxServeBtc.CandleData.create_bitcoin()

    bitcoin
  end
end
