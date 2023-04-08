defmodule Voicepilot.Business.Site do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :text, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [:title, :url, :text])
    |> validate_required([:title, :url, :text])
  end
end
