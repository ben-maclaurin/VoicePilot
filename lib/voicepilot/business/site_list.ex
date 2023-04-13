defmodule Voicepilot.Business.SiteList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sitelists" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(site_list, attrs) do
    site_list
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
