defmodule Voicepilot.Repo.Migrations.CreateSitelists do
  use Ecto.Migration

  def change do
    create table(:sitelists) do
      add :title, :string

      timestamps()
    end
  end
end
