defmodule Voicepilot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      VoicepilotWeb.Telemetry,
      # Start the Ecto repository
      Voicepilot.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Voicepilot.PubSub},
      # Start Finch
      {Finch, name: Voicepilot.Finch},
      # Start the Endpoint (http/https)
      VoicepilotWeb.Endpoint
      # Start a worker by calling: Voicepilot.Worker.start_link(arg)
      # {Voicepilot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Voicepilot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VoicepilotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
