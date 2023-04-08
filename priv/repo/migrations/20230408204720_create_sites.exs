defmodule Voicepilot.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :title, :string
      add :url, :string
      add :text, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
