defmodule Voicepilot.Extract do
  def extract_article_text(url) do
    summary = Readability.summarize(url)

    limit_to_1000_words(summary.article_text)
  end

  def limit_to_1000_words(string) do
    string
    |> String.split()
    |> Enum.take(1000)
    |> Enum.join(" ")
  end
end
