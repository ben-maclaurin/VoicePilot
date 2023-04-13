defmodule Voicepilot.Repo.Migrations.AddSiteListRelationToSites do
  use Ecto.Migration

  def change do
    alter table(:sites) do
      add :site_list_id, references(:site_lists, on_delete: nothing)
    end

  end
end
