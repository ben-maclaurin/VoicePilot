defmodule Voicepilot.TTS do
  alias HTTPoison
  import Voicepilot.Business

  def convert(site) do
    url = "https://play.ht/api/v1/convert"

    headers = [
      {"Authorization", "Bearer *"},
      {"X-User-ID", "*"},
      {"Content-Type", "application/json"}
    ]

    voice = get_voice!(site["voice_id"])

    json_body =
      %{
        "voice" => voice.voice_id,
        "content" => [site["transcript"]]
      }
      |> Jason.encode!()

    case HTTPoison.post(url, json_body, headers) do
      {:ok, response} ->
        IO.inspect(response, label: "Success response")
        {:ok, response}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason, label: "Error reason")
        {:error, reason}
    end
  end
end
