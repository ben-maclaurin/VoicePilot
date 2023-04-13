defmodule VoicepilotWeb.SiteListLive.Index do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business
  alias Voicepilot.Business.SiteList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :sitelists, Business.list_sitelists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Site list")
    |> assign(:site_list, Business.get_site_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Site list")
    |> assign(:site_list, %SiteList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sitelists")
    |> assign(:site_list, nil)
  end

  @impl true
  def handle_info({VoicepilotWeb.SiteListLive.FormComponent, {:saved, site_list}}, socket) do
    {:noreply, stream_insert(socket, :sitelists, site_list)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    site_list = Business.get_site_list!(id)
    {:ok, _} = Business.delete_site_list(site_list)

    {:noreply, stream_delete(socket, :sitelists, site_list)}
  end
end
