defmodule Voicepilot.Repo.Migrations.CreateVoices do
  use Ecto.Migration

  def change do
    create table(:voices) do
      add :voice_id, :string
      add :site_id, references(:sites, on_delete: :nothing)

      timestamps()
    end

    create index(:voices, [:site_id])
  end
end
