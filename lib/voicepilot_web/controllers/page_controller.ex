defmodule VoicepilotWeb.PageController do
  use VoicepilotWeb, :controller
  import Voicepilot.Business

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def tts_callback(conn, params) do
    IO.puts("This message was posted")

    if params["status"] === "SUCCESS" do
      site = get_site_by_transcription_id(params["transcriptionId"])
      IO.puts(site)
      update_site(site, %{filename: params["output"]})
    end

    IO.inspect(params)

    send_resp(conn, 200, "acknowledged")
  end
end
