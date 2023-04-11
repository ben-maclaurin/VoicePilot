defmodule Voicepilot.Business.Voice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "voices" do
    field(:voice_id, :string)
    field(:site_id, :id)
    has_many(:sites, Site)

    timestamps()
  end

  @doc false
  def changeset(voice, attrs) do
    voice
    |> cast(attrs, [:voice_id])
    |> validate_required([:voice_id])
  end
end
