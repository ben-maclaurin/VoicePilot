defmodule Voicepilot.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :title, :string
      add :url, :string
      add :text, :text

      timestamps()
    end
  end
end
