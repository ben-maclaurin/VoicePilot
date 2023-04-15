defmodule Voicepilot.Prepare do
  def remove_brackets(text) do
    regex = ~r/\((.*?)\)|\[(.*?)\]/
    String.replace(text, regex, "")
  end

  def remove_links(text) do
    url_regex = ~r/\b(?:https?|ftp):\/\/\S+\b/i
    String.replace(text, url_regex, "")
  end

  def remove_symbols(text) do
    non_alphanumeric_space_period_comma_regex = ~r/[^a-zA-Z0-9\s\.,]+/
    String.replace(text, non_alphanumeric_space_period_comma_regex, "")
  end

  def replace_hyphens_with_spaces(text) do
    String.replace(text, "-", " ")
  end

  def resolve_abbreviations(text) do
    url = "https://api.openai.com/v1/chat/completions"

    headers = [
      {"Authorization", "Bearer #{Application.get_env(:voicepilot, :openai_api_key)}"},
      {"Content-Type", "application/json"}
    ]

    json_body =
      %{
        "model" => "gpt-3.5-turbo",
        "messages" => [
          %{
            "role" => "user",
            "content" =>
              "Given the following text, if you find an abbreviation or acronym, replace it with the full version or expanded version. If you don't know what it is, make a best guess: = TEXT START = #{text} = TEXT END ="
          }
        ]
      }
      |> Jason.encode!()

    case HTTPoison.post(url, json_body, headers, timeout: 120_000, recv_timeout: 120_000) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        decode_json_and_get_content(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason, label: "Error reason")
        {:error, reason}
    end
  end

  def decode_json_and_get_content(json_string) do
    case Jason.decode(json_string) do
      {:ok, decoded_data} ->
        content = get_content(decoded_data)
        IO.inspect(content, label: "Content")

      {:error, reason} ->
        IO.puts("Failed to decode JSON: #{reason}")
    end
  end

  defp get_content(decoded_data) do
    choices = Map.get(decoded_data, "choices")
    first_choice = Enum.at(choices, 0)
    message = Map.get(first_choice, "message")
    Map.get(message, "content")
  end
end
