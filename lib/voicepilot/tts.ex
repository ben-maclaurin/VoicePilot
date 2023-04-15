defmodule Voicepilot.TTS do
  alias HTTPoison
  import Voicepilot.Business

  def convert_and_return_id(site) do
    url = "https://play.ht/api/v1/convert"

    headers = [
      {"Authorization", "Bearer #{Application.get_env(:voicepilot, :play_ht_api_key)}"},
      {"X-User-ID", "lvvulvZRetS5eHidlUyyT4cCfmM2"},
      {"Content-Type", "application/json"}
    ]

#    classla/xlm-roberta-base-multilingual-text-genre-classifier

    voice = get_voice!(site["voice_id"])

    json_body =
      %{
        "voice" => voice.voice_id,
        "content" => [site["transcript"]]
      }
      |> Jason.encode!()

    case HTTPoison.post(url, json_body, headers) do
      {:ok, %HTTPoison.Response{body: body, status_code: 201}} ->
        {:ok, parsed_body} = Jason.decode(body)

        transcription_id = Map.get(parsed_body, "transcriptionId")
        {:ok, transcription_id}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason, label: "Error reason")
        {:error, reason}
    end
  end
end
