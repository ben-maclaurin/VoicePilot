defmodule Voicepilot.Repo.Migrations.RemoveSiteIdFromVoices do
  use Ecto.Migration

  def change do
    alter table(:voices) do
      remove :site_id
    end
  end
end
