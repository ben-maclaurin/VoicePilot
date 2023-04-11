defmodule Voicepilot.Business.Voice do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voicepilot.Business.Site

  schema "voices" do
    field(:voice_id, :string)
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
