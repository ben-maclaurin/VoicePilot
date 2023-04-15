defmodule VoicepilotWeb.SiteLive.Show do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business
  alias HTTPoison

  @impl true
  def mount(params, _session, socket) do
    status = "SUCCESS"

    {:ok, socket |> assign(:status, status)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:site, Business.get_site!(id))}
  end

  defp page_title(:show), do: "Show Site"
  defp page_title(:edit), do: "Edit Site"
end
