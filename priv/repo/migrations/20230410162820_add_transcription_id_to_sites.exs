defmodule Voicepilot.Repo.Migrations.AddTranscriptionIdToSites do
  use Ecto.Migration

  def change do
    alter table(:sites) do
      add :transcription_id, :string
    end
  end
end
