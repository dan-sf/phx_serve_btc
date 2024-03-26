defmodule PhxServeBtc.CandleData.Bitcoin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "btc_candles" do
    field :close, :float
    field :high, :float
    field :low, :float
    field :open, :float
    field :currency, :string
    field :day, :date
    field :volume, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bitcoin, attrs) do
    bitcoin
    |> cast(attrs, [:day, :open, :high, :low, :close, :volume, :currency])
    |> validate_required([:day, :open, :high, :low, :close, :volume, :currency])
    |> unique_constraint(:day)
  end
end
