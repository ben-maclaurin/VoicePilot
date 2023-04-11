defmodule Voicepilot.Repo.Migrations.AddVoiceIdToSites do
  use Ecto.Migration

  def change do
    alter table(:sites) do
      add :voice_id, references(:voices, on_delete: :nothing)
    end
  end
end
