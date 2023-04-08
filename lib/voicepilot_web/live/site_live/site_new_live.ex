defmodule VoicepilotWeb.SiteNewLive do
  use VoicepilotWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, user: socket.assigns.current_user)}
  end

  def handle_event("new", site_params, socket) do
    case Voicepilot.Business.create_site(site_params) do
      {:ok, site} ->
        site

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("this happenede")
        IO.inspect(changeset)
        assign(socket, changeset: changeset)
    end

    {:noreply, socket}
  end
end
