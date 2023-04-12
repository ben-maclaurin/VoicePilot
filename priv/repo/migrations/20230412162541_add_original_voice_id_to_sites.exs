defmodule Voicepilot.Repo.Migrations.AddOriginalVoiceIdToSites do
  use Ecto.Migration

  def change do
    alter table(:sites) do
      add :original_voice_id, :string
    end
  end
end
