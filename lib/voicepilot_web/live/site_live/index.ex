defmodule VoicepilotWeb.SiteLive.Index do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business
  alias Voicepilot.Business.Site

  @impl true
  def mount(_params, _session, socket) do
    voices = Business.list_voices()

    {:ok, stream(socket |> assign(:voices, voices), :sites, Business.list_sites())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Site")
    |> assign(:user, socket.assigns.current_user)
    |> assign(:site, Business.get_site!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Site")
    |> assign(:user, socket.assigns.current_user)
    |> assign(:site, %Site{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sites")
    |> assign(:site, nil)
  end

  @impl true
  def handle_info({VoicepilotWeb.SiteLive.FormComponent, {:saved, site}}, socket) do
    {:noreply, stream_insert(socket, :sites, site)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    site = Business.get_site!(id)
    {:ok, _} = Business.delete_site(site)

    {:noreply, stream_delete(socket, :sites, site)}
  end
end
