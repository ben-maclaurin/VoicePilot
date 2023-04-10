defmodule Voicepilot.Repo.Migrations.RenameTextToTranscriptForSites do
  use Ecto.Migration

  def change do
    rename table(:sites), :text, to: :transcript
  end
end
