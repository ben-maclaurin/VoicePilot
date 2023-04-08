defmodule VoicepilotWeb.SiteViewLive do
  use VoicepilotWeb, :live_view
  alias Voicepilot.Business

  def mount(params, _session, socket) do
    IO.inspect(params)

    site =
      case Business.get_site!(params["id"]) do
        %Business.Site{} = site ->
          site

        nil ->
          %{"error" => "Site was not found"}
      end

    {:ok, assign(socket, site: site)}
  end
end
