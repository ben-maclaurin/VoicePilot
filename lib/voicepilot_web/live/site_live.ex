defmodule VoicepilotWeb.SiteLive do
  use VoicepilotWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
