defmodule Voicepilot.BusinessTest do
  use Voicepilot.DataCase

  alias Voicepilot.Business

  describe "sites" do
    alias Voicepilot.Business.Site

    import Voicepilot.BusinessFixtures

    @invalid_attrs %{text: nil, title: nil, url: nil}

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Business.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Business.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      valid_attrs = %{text: "some text", title: "some title", url: "some url"}

      assert {:ok, %Site{} = site} = Business.create_site(valid_attrs)
      assert site.text == "some text"
      assert site.title == "some title"
      assert site.url == "some url"
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()

      update_attrs = %{
        text: "some updated text",
        title: "some updated title",
        url: "some updated url"
      }

      assert {:ok, %Site{} = site} = Business.update_site(site, update_attrs)
      assert site.text == "some updated text"
      assert site.title == "some updated title"
      assert site.url == "some updated url"
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_site(site, @invalid_attrs)
      assert site == Business.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Business.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Business.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Business.change_site(site)
    end
  end

  describe "voices" do
    alias Voicepilot.Business.Voice

    import Voicepilot.BusinessFixtures

    @invalid_attrs %{voice_id: nil}

    test "list_voices/0 returns all voices" do
      voice = voice_fixture()
      assert Business.list_voices() == [voice]
    end

    test "get_voice!/1 returns the voice with given id" do
      voice = voice_fixture()
      assert Business.get_voice!(voice.id) == voice
    end

    test "create_voice/1 with valid data creates a voice" do
      valid_attrs = %{voice_id: "some voice_id"}

      assert {:ok, %Voice{} = voice} = Business.create_voice(valid_attrs)
      assert voice.voice_id == "some voice_id"
    end

    test "create_voice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_voice(@invalid_attrs)
    end

    test "update_voice/2 with valid data updates the voice" do
      voice = voice_fixture()
      update_attrs = %{voice_id: "some updated voice_id"}

      assert {:ok, %Voice{} = voice} = Business.update_voice(voice, update_attrs)
      assert voice.voice_id == "some updated voice_id"
    end

    test "update_voice/2 with invalid data returns error changeset" do
      voice = voice_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_voice(voice, @invalid_attrs)
      assert voice == Business.get_voice!(voice.id)
    end

    test "delete_voice/1 deletes the voice" do
      voice = voice_fixture()
      assert {:ok, %Voice{}} = Business.delete_voice(voice)
      assert_raise Ecto.NoResultsError, fn -> Business.get_voice!(voice.id) end
    end

    test "change_voice/1 returns a voice changeset" do
      voice = voice_fixture()
      assert %Ecto.Changeset{} = Business.change_voice(voice)
    end
  end
end
