defmodule VoicepilotWeb.SiteNewLive do
  use VoicepilotWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("new", site_params, socket) do
    site_params_with_user_id = Map.put(site_params, "user_id", socket.assigns.current_user.id)

    case Voicepilot.Business.create_site(site_params_with_user_id) do
      {:ok, site} ->
        site

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end

    {:noreply, socket}
  end
end
