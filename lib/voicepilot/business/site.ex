defmodule Voicepilot.Business.Site do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voicepilot.Accounts.User
  alias Voicepilot.Business.Voice
  alias Voicepilot.Business.SiteList

  schema "sites" do
    field(:transcript, :string)
    field(:title, :string)
    field(:url, :string)
    field(:filename, :string)
    field(:transcription_id, :string)
    belongs_to(:user, User)
    belongs_to(:voice, Voice)
    belongs_to(:site_list, SiteList)
    field(:original_voice_id, :string)

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [
      :title,
      :url,
      :transcript,
      :transcription_id,
      :user_id,
      :filename,
      :voice_id,
      :original_voice_id
    ])
    |> validate_required([
      :title,
      :url,
      :user_id,
      :voice_id,
      :transcription_id,
      :original_voice_id
    ])
  end
end
