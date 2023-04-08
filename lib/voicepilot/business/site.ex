defmodule Voicepilot.Business.Site do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voicepilot.Accounts.User

  schema "sites" do
    field(:text, :string)
    field(:title, :string)
    field(:url, :string)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [:title, :url, :text, :user_id])
    |> validate_required([:title, :url, :user_id])
    |> unique_constraint(:user_id)
  end
end
