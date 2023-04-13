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

  @doc """
  Generate a site_list.
  """
  def site_list_fixture(attrs \\ %{}) do
    {:ok, site_list} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Voicepilot.Business.create_site_list()

    site_list
  end
end
