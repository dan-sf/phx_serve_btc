defmodule PhxServeBtc.CandleData do
  @moduledoc """
  The CandleData context.
  """

  import Ecto.Query, warn: false
  alias PhxServeBtc.Repo

  alias PhxServeBtc.CandleData.Bitcoin

  @doc """
  Returns the list of btc_candles.

  ## Examples

      iex> list_btc_candles()
      [%Bitcoin{}, ...]

  """
  def list_btc_candles do
    Repo.all(Bitcoin)
  end


  @doc """
  Returns the list of btc_candles. From given start_date to end_date (exclusive)
  """
  def list_btc_candles_date_range(start_date, end_date) do
    Repo.all(
      from bc in Bitcoin,
        where: bc.day >= ^start_date and bc.day < ^end_date
    )
  end


  @doc """
  Gets a single bitcoin.

  Raises `Ecto.NoResultsError` if the Bitcoin does not exist.

  ## Examples

      iex> get_bitcoin!(123)
      %Bitcoin{}

      iex> get_bitcoin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bitcoin!(id), do: Repo.get!(Bitcoin, id)

  @doc """
  Creates a bitcoin.

  ## Examples

      iex> create_bitcoin(%{field: value})
      {:ok, %Bitcoin{}}

      iex> create_bitcoin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bitcoin(attrs \\ %{}) do
    %Bitcoin{}
    |> Bitcoin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bitcoin.

  ## Examples

      iex> update_bitcoin(bitcoin, %{field: new_value})
      {:ok, %Bitcoin{}}

      iex> update_bitcoin(bitcoin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bitcoin(%Bitcoin{} = bitcoin, attrs) do
    bitcoin
    |> Bitcoin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bitcoin.

  ## Examples

      iex> delete_bitcoin(bitcoin)
      {:ok, %Bitcoin{}}

      iex> delete_bitcoin(bitcoin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bitcoin(%Bitcoin{} = bitcoin) do
    Repo.delete(bitcoin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bitcoin changes.

  ## Examples

      iex> change_bitcoin(bitcoin)
      %Ecto.Changeset{data: %Bitcoin{}}

  """
  def change_bitcoin(%Bitcoin{} = bitcoin, attrs \\ %{}) do
    Bitcoin.changeset(bitcoin, attrs)
  end
end
