defmodule VoicepilotWeb.PageController do
  use VoicepilotWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def tts_callback(conn, params) do
    IO.puts("This message was posted")

    IO.inspect(params)

    send_resp(conn, 200, "acknowledged")
  end
end
