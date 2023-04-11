defmodule VoicepilotWeb.VoiceLive.Index do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business
  alias Voicepilot.Business.Voice

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :voices, Business.list_voices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Voice")
    |> assign(:voice, Business.get_voice!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Voice")
    |> assign(:voice, %Voice{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Voices")
    |> assign(:voice, nil)
  end

  @impl true
  def handle_info({VoicepilotWeb.VoiceLive.FormComponent, {:saved, voice}}, socket) do
    {:noreply, stream_insert(socket, :voices, voice)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    voice = Business.get_voice!(id)
    {:ok, _} = Business.delete_voice(voice)

    {:noreply, stream_delete(socket, :voices, voice)}
  end
end
