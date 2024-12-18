defmodule Discovery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      chat: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      # Start the Telemetry supervisor
      DiscoveryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Discovery.PubSub},
      # Start the Endpoint (http/https)
      DiscoveryWeb.Endpoint,
      # Start a worker by calling: Discovery.Worker.start_link(arg)
      # {Discovery.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: Discovery.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Discovery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DiscoveryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
