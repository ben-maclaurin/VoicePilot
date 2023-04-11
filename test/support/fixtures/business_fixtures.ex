defmodule Voicepilot.BusinessFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Voicepilot.Business` context.
  """

  @doc """
  Generate a site.
  """
  def site_fixture(attrs \\ %{}) do
    {:ok, site} =
      attrs
      |> Enum.into(%{
        text: "some text",
        title: "some title",
        url: "some url"
      })
      |> Voicepilot.Business.create_site()

    site
  end

  @doc """
  Generate a voice.
  """
  def voice_fixture(attrs \\ %{}) do
    {:ok, voice} =
      attrs
      |> Enum.into(%{
        voice_id: "some voice_id"
      })
      |> Voicepilot.Business.create_voice()

    voice
  end
end
