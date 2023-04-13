defmodule VoicepilotWeb.SiteLive.Show do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Business
  alias HTTPoison

  @impl true
  def mount(params, _session, socket) do
    # site = Business.get_site!(params["id"])

    # status =
    #   case HTTPoison.get(site.filename) do
    #     {:ok, %HTTPoison.Response{status_code: 200, body: _body}} ->
    #       "SUCCESS"

    #     {:ok, %HTTPoison.Response{status_code: _status_code, body: _body}} ->
    #       "LOADING"

    #     {:error, %HTTPoison.Error{reason: _reason}} ->
    #       "ERROR"
    #   end

    status = "SUCCESS"

    {:ok, socket |> assign(:status, status)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, socket.assigns.current_user)
     |> assign(:site, Business.get_site!(id))}
  end

  defp page_title(:show), do: "Show Site"
  defp page_title(:edit), do: "Edit Site"
end
