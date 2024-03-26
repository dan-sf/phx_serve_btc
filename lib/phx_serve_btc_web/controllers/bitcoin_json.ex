defmodule PhxServeBtcWeb.BitcoinJSON do
  alias PhxServeBtc.CandleData.Bitcoin

  @doc """
  Renders a list of btc_candles.
  """
  def index(%{btc_candles: btc_candles}) do
    %{data: for(bitcoin <- btc_candles, do: data(bitcoin))}
  end

  @doc """
  Renders a single bitcoin.
  """
  def show(%{bitcoin: bitcoin}) do
    %{data: data(bitcoin)}
  end

  defp data(%Bitcoin{} = bitcoin) do
    %{
      id: bitcoin.id,
      day: bitcoin.day,
      open: bitcoin.open,
      high: bitcoin.high,
      low: bitcoin.low,
      close: bitcoin.close,
      volume: bitcoin.volume,
      currency: bitcoin.currency
    }
  end
end
