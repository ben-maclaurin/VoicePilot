defmodule Voicepilot.Extract do
  import Readability

  def extract_article_text(url) do
    summary = Readability.summarize(url)

    summary.article_text
  end
end
