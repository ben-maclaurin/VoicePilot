defmodule Voicepilot.Repo do
  use Ecto.Repo,
    otp_app: :voicepilot,
    adapter: Ecto.Adapters.Postgres
end
