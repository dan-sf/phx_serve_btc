defmodule PhxServeBtc.Repo.Migrations.CreateBtcCandles do
  use Ecto.Migration

  def change do
    create table(:btc_candles) do
      add :day, :date
      add :open, :float
      add :high, :float
      add :low, :float
      add :close, :float
      add :volume, :float
      add :currency, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:btc_candles, [:day])
  end
end
