defmodule Voicepilot.Business do
  @moduledoc """
  The Business context.
  """

  import Ecto.Query, warn: false
  alias Voicepilot.Repo

  alias Voicepilot.Business.Site

  @doc """
  Returns the list of sites.

  ## Examples

      iex> list_sites()
      [%Site{}, ...]

  """
  def list_sites do
    Repo.all(Site)
  end

  @doc """
  Gets a single site.

  Raises `Ecto.NoResultsError` if the Site does not exist.

  ## Examples

      iex> get_site!(123)
      %Site{}

      iex> get_site!(456)
      ** (Ecto.NoResultsError)

  """
  def get_site!(id), do: Repo.get!(Site, id)

  def get_site_by_transcription_id(transcription_id) do
    query = from(site in Site, where: site.transcription_id == ^transcription_id)

    Repo.one(query)
  end

  @doc """
  Creates a site.

  ## Examples

      iex> create_site(%{field: value})
      {:ok, %Site{}}

      iex> create_site(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_site(attrs \\ %{}) do
    site = Map.put(attrs, "transcript", Voicepilot.Extract.extract_article_text(attrs["url"]))

    transcription_id =
      case Voicepilot.TTS.convert_and_return_id(site) do
        {:ok, transcription_id} ->
          transcription_id
      end

    site = Map.put(site, "transcription_id", transcription_id)

    site = Map.put(site, "original_voice_id", attrs["voice_id"])

    site =
      Map.put(
        site,
        "filename",
        "https://peregrine-results.s3.us-east-2.amazonaws.com/results/#{transcription_id}_0.wav"
      )

    %Site{}
    |> Site.changeset(site)
    |> Repo.insert()
  end

  @doc """
  Updates a site.

  ## Examples

      iex> update_site(site, %{field: new_value})
      {:ok, %Site{}}

      iex> update_site(site, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_site(%Site{} = site, attrs) do
    site
    |> Site.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a site.

  ## Examples

      iex> delete_site(site)
      {:ok, %Site{}}

      iex> delete_site(site)
      {:error, %Ecto.Changeset{}}

  """
  def delete_site(%Site{} = site) do
    Repo.delete(site)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site changes.

  ## Examples

      iex> change_site(site)
      %Ecto.Changeset{data: %Site{}}

  """
  def change_site(%Site{} = site, attrs \\ %{}) do
    Site.changeset(site, attrs)
  end

  alias Voicepilot.Business.Voice

  @doc """
  Returns the list of voices.

  ## Examples

      iex> list_voices()
      [%Voice{}, ...]

  """
  def list_voices do
    Repo.all(Voice)
  end

  @doc """
  Gets a single voice.

  Raises `Ecto.NoResultsError` if the Voice does not exist.

  ## Examples

      iex> get_voice!(123)
      %Voice{}

      iex> get_voice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_voice!(id), do: Repo.get!(Voice, id)

  @doc """
  Creates a voice.

  ## Examples

      iex> create_voice(%{field: value})
      {:ok, %Voice{}}

      iex> create_voice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_voice(attrs \\ %{}) do
    %Voice{}
    |> Voice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a voice.

  ## Examples

      iex> update_voice(voice, %{field: new_value})
      {:ok, %Voice{}}

      iex> update_voice(voice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_voice(%Voice{} = voice, attrs) do
    voice
    |> Voice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a voice.

  ## Examples

      iex> delete_voice(voice)
      {:ok, %Voice{}}

      iex> delete_voice(voice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_voice(%Voice{} = voice) do
    Repo.delete(voice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking voice changes.

  ## Examples

      iex> change_voice(voice)
      %Ecto.Changeset{data: %Voice{}}

  """
  def change_voice(%Voice{} = voice, attrs \\ %{}) do
    Voice.changeset(voice, attrs)
  end

  alias Voicepilot.Business.SiteList

  @doc """
  Returns the list of sitelists.

  ## Examples

      iex> list_sitelists()
      [%SiteList{}, ...]

  """
  def list_sitelists do
    Repo.all(SiteList)
  end

  @doc """
  Gets a single site_list.

  Raises `Ecto.NoResultsError` if the Site list does not exist.

  ## Examples

      iex> get_site_list!(123)
      %SiteList{}

      iex> get_site_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_site_list!(id), do: Repo.get!(SiteList, id)

  @doc """
  Creates a site_list.

  ## Examples

      iex> create_site_list(%{field: value})
      {:ok, %SiteList{}}

      iex> create_site_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_site_list(attrs \\ %{}) do
    %SiteList{}
    |> SiteList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a site_list.

  ## Examples

      iex> update_site_list(site_list, %{field: new_value})
      {:ok, %SiteList{}}

      iex> update_site_list(site_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_site_list(%SiteList{} = site_list, attrs) do
    site_list
    |> SiteList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a site_list.

  ## Examples

      iex> delete_site_list(site_list)
      {:ok, %SiteList{}}

      iex> delete_site_list(site_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_site_list(%SiteList{} = site_list) do
    Repo.delete(site_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site_list changes.

  ## Examples

      iex> change_site_list(site_list)
      %Ecto.Changeset{data: %SiteList{}}

  """
  def change_site_list(%SiteList{} = site_list, attrs \\ %{}) do
    SiteList.changeset(site_list, attrs)
  end
end
