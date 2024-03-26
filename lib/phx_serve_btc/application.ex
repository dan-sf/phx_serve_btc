defmodule PhxServeBtc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxServeBtcWeb.Telemetry,
      PhxServeBtc.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:phx_serve_btc, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:phx_serve_btc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxServeBtc.PubSub},
      # Start a worker by calling: PhxServeBtc.Worker.start_link(arg)
      # {PhxServeBtc.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxServeBtcWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxServeBtc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxServeBtcWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
