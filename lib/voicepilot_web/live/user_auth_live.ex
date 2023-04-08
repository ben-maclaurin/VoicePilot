defmodule VoicepilotWeb.UserAuthLive do
  use VoicepilotWeb, :live_view

  alias Voicepilot.Accounts

  def on_mount(_, _params, %{"user_token" => user_token}, socket) do
    socket =
      socket
      |> assign(:user, Accounts.get_user_by_session_token(user_token))

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end
end
