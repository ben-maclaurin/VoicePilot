defmodule Voicepilot.Repo.Migrations.RemoveVoiceFromSites do
  use Ecto.Migration

  def change do
    alter table("sites") do
      remove :voice
    end
  end
end
