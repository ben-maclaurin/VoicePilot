defmodule Voicepilot.TTS do
  alias HTTPoison

  def convert_text_to_speech(site) do
    url = "https://play.ht/api/v1/convert"

    headers = [
      {"Authorization", "Bearer #{Application.fetch_env!(:play_ht, :api_key)}"},
      {"X-User-ID", Application.fetch_env!(:play_ht, :user_id)},
      {"Content-Type", "application/json"}
    ]

    json_body =
      %{
        "voice" => site.voice_id,
        "content" => site.transcript
      }
      |> Jason.encode!()

    HTTPoison.post(url, json_body, headers)
  end
end
