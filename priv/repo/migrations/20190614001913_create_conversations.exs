defmodule Agora.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :org_id, references(:orgs, on_delete: :nothing)

      timestamps()
    end

    create index(:conversations, [:org_id])
  end
end
