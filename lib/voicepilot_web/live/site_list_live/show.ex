defmodule VoicepilotWeb.SiteListLive.Show do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:site_list, Business.get_site_list!(id))}
  end

  defp page_title(:show), do: "Show Site list"
  defp page_title(:edit), do: "Edit Site list"
end
