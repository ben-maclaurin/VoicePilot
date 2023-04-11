defmodule Voicepilot.Business.Site do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voicepilot.Accounts.User

  schema "sites" do
    field(:transcript, :string)
    field(:title, :string)
    field(:url, :string)
    field(:filename, :string)
    field(:transcription_id, :string)
    belongs_to(:user, User)
    belongs_to(:voice, Voice)

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [:title, :url, :transcript, :transcription_id, :user_id, :voice_id])
    |> validate_required([:title, :url, :user_id, :voice_id, :transcription_id])
  end
end
