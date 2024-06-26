defmodule PhxServeBtc.SeedCandleData do
  @moduledoc """
  Function to seed the btc data
  """

  import Ecto.Query, warn: false
  alias PhxServeBtc.Repo

  alias PhxServeBtc.CandleData.Bitcoin

  def seed(path) do
    Repo.delete_all(Bitcoin)

    File.stream!(path)
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.drop(1)
    |> Enum.map(fn _ = [day, open, high, low, close, volume, currency] ->
      Bitcoin.changeset(
        %Bitcoin{},
        %{
          "day" => day,
          "open" => open,
          "high" => high,
          "low" => low,
          "close" => close,
          "volume" => volume,
          "currency" => currency
        }
      )
    end)
    |> Enum.each(&Repo.insert!/1)
  end
end
