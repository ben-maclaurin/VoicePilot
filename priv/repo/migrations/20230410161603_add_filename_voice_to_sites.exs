defmodule Voicepilot.Repo.Migrations.AddFilenameVoiceToSites do
  use Ecto.Migration

  def change do
    alter table(:sites) do
      add :filename, :string
      add :voice, :string
    end
  end
end
